class FieldControl
  constructor: (part_of_class, field_type) ->
    if $(".#{part_of_class}_fields").length > 0
      actions_template = $("#template_actions_for_#{part_of_class}").text()
      $(".#{part_of_class}_fields").append(actions_template)
      $("##{part_of_class}_add_new_one").on 'click', (event) ->
        num_fields = $(".#{part_of_class}_fields input").length
        template = _.template($("#template_#{part_of_class}").text())
        new_field = template({index: num_fields + 1})
        $(event.currentTarget).before(new_field)
        return false

      $(".#{part_of_class}_fields").on 'click', ".remove_#{part_of_class}_field", (event) ->
        (event.currentTarget).closest('p').remove()
        return false

class ValidationForForm
  constructor: ->
    if $('.edit_user').length > 0
      $('.edit_user').on 'submit', (event) =>
        @clear_from_errors()

        $(event.currentTarget).find('input[type=email]').each (index, el) ->
          if $(el).val().length > 0
            re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            if re.test($(el).val()) == false
              error_message = $('<span />')
              error_message.addClass('error_message')
              error_message.text('Invalid email')
              $(el).after(error_message)

        $(event.currentTarget).find('input[type=tel]').each (index, el) ->
          if $(el).val().length > 0
            re = /^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/;
            if re.test($(el).val()) == false
              error_message = $('<span />')
              error_message.addClass('error_message')
              error_message.text('Invalid phone, example 8(926)123-45-67')
              $(el).after(error_message)

        if $('.edit_user').find('.error_message').length > 0
          return false
        else
          return true

  clear_from_errors: ->
    $('.edit_user').find('.error_message').remove()

$ ->
  new FieldControl('phone_number')
  new FieldControl('email')
  new ValidationForForm

