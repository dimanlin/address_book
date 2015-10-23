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
  constructor: (form_class) ->

    @form_class = form_class

    if $(form_class).length > 0
      $(form_class).on 'submit', (event) =>
        @clear_from_errors()
        @validate_presence(["#user_first_name", "#user_last_name"])

        presence_email = _.filter $(event.currentTarget).find('input[type=email]'), (el) ->
              return $(el).val().length > 0
        if presence_email.length == 0
          @add_error_message($(event.currentTarget).find('input[type=email]:first'), "can't be blank")

        presence_phone_number = _.filter $(event.currentTarget).find('input[type=tel]'), (el) ->
          return $(el).val().length > 0
        if presence_phone_number.length == 0
          @add_error_message($(event.currentTarget).find('input[type=tel]:first'), "can't be blank")

        $(event.currentTarget).find('input[type=email]').each (index, el) =>
          if $(el).val().length > 0
            re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            if re.test($(el).val()) == false
              @add_error_message($(el), "invalid format")

        $(event.currentTarget).find('input[type=tel]').each (index, el) =>
          if $(el).val().length > 0
            re = /^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/;
            if re.test($(el).val()) == false
              @add_error_message($(el), 'Invalid phone, example 8(926)123-45-67')

        if $(form_class).find('.error_message').length > 0
          return false
        else
          return true

  clear_from_errors: ->
    $(@form_class).find('.error_message').remove()

  add_error_message: (el, message) ->
    error_message = $('<span />')
    error_message.addClass('error_message')
    error_message.text(message)
    $(el).after(error_message)

  validate_presence: (filds_arr) =>
    _.each filds_arr, (el) =>
      @add_error_message($(el), "can't be blank") if $(el).val().length == 0


class Search
  constructor: () ->
    $('.search_field').length > 0
    $('.search_field').on 'keyup', (event) ->
      $('.user_info').show()
      val = $(event.currentTarget).val()
      unless val.length == 0
        $('.user_info').each (index, el) ->
          re = new RegExp(val)
          if re.test($(el).text()) == true
            $(el).show()
          else
            $(el).hide()

$ ->
  new FieldControl('phone_number')
  new FieldControl('email')
  new ValidationForForm('.edit_user, .new_user')
  new Search

