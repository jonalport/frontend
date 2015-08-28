define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var DisableSubmitBtn,
      defaultConfig = {
        disabledClass: 'is-disabled'
      };

  DisableSubmitBtn = function($el, config) {
    DisableSubmitBtn.baseConstructor.call(this, $el, config, defaultConfig);

    this.$submitButton = this.$el.find('[type=submit]');
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(DisableSubmitBtn);

  DisableSubmitBtn.componentName = 'DisableSubmitBtn';

  /**
  * Addds the listener to the button to disable it when the form  is submitted
  */
  DisableSubmitBtn.prototype._addListener = function() {
    var self = this;

    this.$el.on('submit',
      function(e) {
        self.$submitButton.addClass(self.config.disabledClass);

        return false;
      }
    );
  }

  /**
  * @param {Promise} initialised
  */
  DisableSubmitBtn.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._addListener();
  };

  return DisableSubmitBtn;
});
