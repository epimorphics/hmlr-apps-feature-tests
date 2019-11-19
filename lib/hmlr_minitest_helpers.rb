# frozen_string_literal

# Matcher to test whether a page has any CSS rules from a given stylesheet
module HmlrMinitestHelpers
  # rubocop:disable Style/MutableConstant
  CSS_CONTENTS_SCRIPT = <<SCRIPT
    (function() {
      var result = false;
      for (var i = 0; i < document.styleSheets.length; i++) {
        stylesheet = document.styleSheets[i];
        if (stylesheet.href && stylesheet.href.match("%<pattern>s") ) {
          result = result || (stylesheet.cssRules.length > 0);
        }
      }
      return result;
    })();
SCRIPT
  # rubocop:enable Style/MutableConstant

  # @return True if the stylesheets of the page include a stylesheet with href
  # matching the pattern and at least one line
  def includes_css_rules_from?(page, pattern)
    page.evaluate_script(format(CSS_CONTENTS_SCRIPT, pattern: pattern))
  end
end

module Minitest
  # Open the base spec class to add helper methods
  class Spec
    include HmlrMinitestHelpers
  end
end
