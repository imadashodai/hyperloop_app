class ShowComfirmation
  include Hyperloop::Component::Mixin

  param :user_data, type: [Hash]
  state show_confirmation: false

  def render
    DIV(class: "to-next") do
      BUTTON(class: "btn") { "Next >>" }.on(:click) { mutate.show_confirmation true }
      show_confirmation(user_data: params.user_data) if state.show_confirmation
    end
  end

  def show_confirmation(user_data)
    UserData(user_data)
  end
end

class UserData < Hyperloop::Component

  param :user_data, type: [Hash]

  render do
    DIV(class: "user-data") do
      params.user_data.each do |key, val|
        LI{"#{key}: #{val}"}
      end
    end
  end
end
