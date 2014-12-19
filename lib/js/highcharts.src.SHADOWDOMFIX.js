  /**
   * Get the bounding box (width, height, x and y) for the element
   */
SVGElement.prototype.getBBox = function () {
    var wrapper = this,
      bBox = wrapper.bBox,
      renderer = wrapper.renderer,
      width,
      height,
      rotation = wrapper.rotation,
      element = wrapper.element,
      styles = wrapper.styles,
      rad = rotation * deg2rad,
      textStr = wrapper.textStr,
      cacheKey;

    // Since numbers are monospaced, and numerical labels appear a lot in a chart,
    // we assume that a label of n characters has the same bounding box as others 
    // of the same length.
    if (textStr === '' || numRegex.test(textStr)) {
      cacheKey = 'num.' + textStr.toString().length + (styles ? ('|' + styles.fontSize + '|' + styles.fontFamily) : '');

    } //else { // This code block made demo/waterfall fail, related to buildText
      // Caching all strings reduces rendering time by 4-5%. 
      // TODO: Check how this affects places where bBox is found on the element
      //cacheKey = textStr + (styles ? ('|' + styles.fontSize + '|' + styles.fontFamily) : '');
    //}
    if (cacheKey) {
      bBox = renderer.cache[cacheKey];
    }

    // No cache found
    if (!bBox) {

      // SVG elements
      if (element.namespaceURI === SVG_NS || renderer.forExport) {
        try { // Fails in Firefox if the container has display: none.

          bBox = element.getBBox ?
            // SVG: use extend because IE9 is not allowed to change width and height in case
            // of rotation (below)
            extend({}, element.getBBox()) :
            // Canvas renderer and legacy IE in export mode
            {
              width: element.offsetWidth,
              height: element.offsetHeight
            };
        } catch (e) {}

        // If the bBox is not set, the try-catch block above failed. The other condition
        // is for Opera that returns a width of -Infinity on hidden elements.
        if (!bBox || bBox.width < 0) {
          bBox = { width: 0, height: 0 };
          /*var cliRect = wrapper.element.getBoundingClientRect();
          bBox = { width: cliRect.width, height: cliRect.height };*/
        }


      // VML Renderer or useHTML within SVG
      } else {

        bBox = wrapper.htmlGetBBox();

      }

      // True SVG elements as well as HTML elements in modern browsers using the .useHTML option
      // need to compensated for rotation
      if (renderer.isSVG) {
        width = bBox.width;
        height = bBox.height;

        // Workaround for wrong bounding box in IE9 and IE10 (#1101, #1505, #1669, #2568)
        if (isIE && styles && styles.fontSize === '11px' && height.toPrecision(3) === '16.9') {
          bBox.height = height = 14;
        }

        // Adjust for rotated text
        if (rotation) {
          bBox.width = mathAbs(height * mathSin(rad)) + mathAbs(width * mathCos(rad));
          bBox.height = mathAbs(height * mathCos(rad)) + mathAbs(width * mathSin(rad));
        }
      }

      // Cache it
      wrapper.bBox = bBox;
      if (cacheKey) {
        renderer.cache[cacheKey] = bBox;
      }
    }
    return bBox;
  };