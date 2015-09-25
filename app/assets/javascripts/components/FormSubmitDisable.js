define(['jquery', 'DoughBaseComponent', 'eventsWithPromises'], function($, DoughBaseComponent, eventsWithPromises) {
  'use strict';

  var FormSubmitDisable,
      defaultConfig = {
        disabledClass: 'is-disabled',
        disabledAttr: 'disabled'
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
    eventsWithPromises.subscribe('formSubmitDisable:formSubmit', $.proxy(function() {
      this._disableSubmitBtn();
    }, this));

    this.$el.on(
      'submit',
      $.proxy(function() {
        eventsWithPromises.publish('formSubmitDisable:formSubmit');
      }, this)
    );
  };

  FormSubmitDisable.prototype._disableSubmitBtn = function() {
    this.$submitButton
      .addClass(this.config.disabledClass)
      .attr('disabled', this.config.disabledAttr);
  }

  /**
  * @param {Promise} initialised
  */
  FormSubmitDisable.prototype.init = function(initialised) {
    this._addListener();
    this._initialisedSuccess(initialised);
  };

  return FormSubmitDisable;
});
