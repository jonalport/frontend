describe.only('FormSubmitDisable', function() {

  'use strict';

  beforeEach(function (done) {
    var self = this;

    requirejs(['jquery', 'FormSubmitDisable'], function ($, FormSubmitDisable) {
      self.$html = $(window.__html__['spec/javascripts/fixtures/FormSubmitDisable.html']);

      self.$submit = self.$html.find('[type="submit"]');
      self.$form = self.$html.find('form');

      self.component = new FormSubmitDisable(self.$html);
      done();
    }, done);
  });

  afterEach(function() {
    // $('body').empty();
  });

  it('is sane', function() {
    expect(true).to.equal(true);
  });

  it('disables the submit button on submit', function() {
    this.$form.on('submit', function(e) {
      e.preventDefault();
    });

    this.$submit.click();

    expect(this.$submit).to.have.class('is-disabled');
  });

});
