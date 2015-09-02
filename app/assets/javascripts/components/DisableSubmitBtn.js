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
  * Adds the listener to the button to disable it when the form is submitted
  */
  DisableSubmitBtn.prototype._addListener = function() {
    this.$el.on(
      'submit',
      $.proxy(function() {
        this.$submitButton.addClass(this.config.disabledClass);
      }, this)
    );
  };

  /**
  * @param {Promise} initialised
  */
  DisableSubmitBtn.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._addListener();
  };

  return DisableSubmitBtn;
});
