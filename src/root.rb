class Root
  include Hyperloop::Component::Mixin

  state header_val: 'Hello World!'
  state row: {}

  def render
    DIV(class: 'burabura-form') do
      DIV(class: 'div-name') do
        LABEL(class: 'name form-label') do
          SPAN{'name:'}
          INPUT(type: :text, class: 'form-control')
        end
      end

      DIV(class: 'hogehoge') do
        BUTTON(type: :button,
          class: 'btn btn-success btn-block') { 'Create an new event' }
            .on(:click) { GetRow.run}
      end
      # H1 {"#{state.header_val}"}
      # GetRow.run.then{|row| mutate.row row.json}
      # puts state.row
      # H2 {"#{state.row}"}
    end
  end

  def get
    Get.run 
  end

  def get_json
    ResStore.set_row
  end
end

class GetRow < Hyperloop::Operation
  step {HTTP.post(
    '/sheet1/create',
    payload: {name: 'imada'}.to_json
    )}
end

#class GetRow < Hyperloop::Operation
#  step {HTTP.get('/get_json')}
#end

#class ResStore < Hyperloop::Store
#  state :row
#
#  def self.set_row
#    mutate.row ResStore.get_row
#  end
#
#  def self.get_row
#    @promise = HTTP.get('/get_json').then do |response|
#      @row = response.json
#    end
#    @promise.then {get_row}
#  end
#end
