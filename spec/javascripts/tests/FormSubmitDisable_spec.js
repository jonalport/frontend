describe('FormSubmitDisable', function() {
  'use strict';

  beforeEach(function (done) {
    var self = this;

    requirejs(['jquery', 'FormSubmitDisable', 'eventsWithPromises'], function ($, FormSubmitDisable, eventsWithPromises) {
      self.$html = $(window.__html__['spec/javascripts/fixtures/FormSubmitDisable.html']);
      self.$submit = self.$html.find('[type="submit"]');
      self.$form = self.$html.find('form');
      self.eventsWithPromises = eventsWithPromises;
      self.component = new FormSubmitDisable(self.$html);

      self.eventsWithPromises.unsubscribeAll();
      self.component.init();

      done();
    }, done);
  });

  afterEach(function() {
    $('body').empty();
  });

  it('disables the submit button on event firing', function() {
    this.eventsWithPromises.publish('formSubmitDisable:formSubmit');

    expect(this.$submit).to.have.class('is-disabled');
    expect(this.$submit.attr('disabled')).to.equal('disabled');
  });
});
