class PhoneNumberFields
  constructor: ->
    if $(".phone_number_fields").length > 0
      actions_template = $('#template_actions_for_phone_number').text()
      $(".phone_number_fields").append(actions_template)
      $('#phone_number_add_new_one').on 'click', (event) ->
        num_fields = $(".phone_number_fields input[type=tel]").length
        template = _.template($('#template_phone_number').text())
        new_field = template({index: num_fields + 1})
        $(event.currentTarget).before(new_field)
        return false

      $('.phone_number_fields').on 'click', '.remove_phone_number_field', (event) ->
        (event.currentTarget).closest('p').remove()

$ ->
  new PhoneNumberFields

