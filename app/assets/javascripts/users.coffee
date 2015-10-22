class FieldControl
  constructor: (type_field) ->
    if $(".#{type_field}_fields").length > 0
      actions_template = $("#template_actions_for_#{type_field}").text()
      $(".#{type_field}_fields").append(actions_template)
      $("##{type_field}_add_new_one").on 'click', (event) ->
        num_fields = $(".#{type_field}_fields input[type=tel]").length
        template = _.template($("#template_#{type_field}").text())
        new_field = template({index: num_fields + 1})
        $(event.currentTarget).before(new_field)
        return false

      $(".#{type_field}_fields").on 'click', ".remove_#{type_field}_field", (event) ->
        (event.currentTarget).closest('p').remove()
        return false

$ ->
  new FieldControl('phone_number')
  new FieldControl('email')

