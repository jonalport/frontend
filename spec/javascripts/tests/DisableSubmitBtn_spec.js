describe.only('DisableSubmitBtn', function() {

  'use strict';

  beforeEach(function (done) {
    var self = this;

    requirejs(['jquery', 'DisableSubmitBtn'], function ($, DisableSubmitBtn) {
      self.$html = $(window.__html__['spec/javascripts/fixtures/DisableSubmitBtn.html']);

      self.$submit = self.$html.find('[type="submit"]');
      self.$form = self.$html.find('form');

      self.component = new DisableSubmitBtn(self.$html);
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
