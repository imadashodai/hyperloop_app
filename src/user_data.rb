require_relative "create_user"

class UserData < Hyperloop::Component

  param :user_data, type: [Hash]

  def render
    user_data = params.user_data
    # list of user input data
    DIV(class: "confirm") do
      user_data.each do |key, val|
        LI{"#{key}: #{val}"}
      end

      # submit button
      DIV(class: 'form-submit') do
        BUTTON(type: :button, class: 'btn btn-success btn-block') { 'Create an new event' }
          .on(:click) { CreateUser.run(
            name: user_data[:name],
            kana: user_data[:kana],
            sex: user_data[:sex],
            tel:  user_data[:tel],
            email: user_data[:email],
            address: user_data[:address],
            check_in: user_data[:check_in],
            check_out: user_data[:check_out],
            number: user_data[:number],
            parking_number: user_data[:parking_number],
            remark: user_data[:remark],
          )}
      end
    end
  end
end
