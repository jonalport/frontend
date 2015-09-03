define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var FormSubmitDisable,
      defaultConfig = {
        disabledClass: 'is-disabled'
      };

  FormSubmitDisable = function($el, config) {
    FormSubmitDisable.baseConstructor.call(this, $el, config, defaultConfig);

    this.$submitButton = this.$el.find('[type=submit]');
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(FormSubmitDisable);

  FormSubmitDisable.componentName = 'FormSubmitDisable';

  /**
  * Adds the listener to the button to disable it when the form is submitted
  */
  FormSubmitDisable.prototype._addListener = function() {
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
  FormSubmitDisable.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._addListener();
  };

  return FormSubmitDisable;
});
