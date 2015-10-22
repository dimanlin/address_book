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

$ ->
  new FieldControl('phone_number')
  new FieldControl('email')

