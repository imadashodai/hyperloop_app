class Root
  include Hyperloop::Component::Mixin

  state header_val: 'Hello World!'
  state row: {}
  state name: ""
  state kana: ""
  state sex: 1
  state tel: ""
  state email: ""
  state email2: "" #Confirmation
  state zipcode: ""
  state address: ""
  state check_in: ""
  state check_out: ""
  state number: 1
  state parking_number: 1
  state remark: ""

  render(DIV) do
    DIV(class: 'formdiv') do
      show_input
    end
  end

  def show_input 
    DIV(class: 'div-name') do
      LABEL(class: 'name form-label') do
        SPAN{'name: '}
        INPUT(type: :text, class: 'form-control').on(:change) do |e|
          mutate.name e.target.value
        end
      end
    end

    DIV(class: 'div-kana') do
      LABEL(class: 'kana form-label') do
        SPAN{'kana: '}
        INPUT(type: :text, class: 'form-control').on(:change) do |e|
          mutate.kana e.target.value
        end
      end
    end

    DIV(class: 'div-sex') do
      SPAN{'sex: '}
      LABEL {'men'}
      INPUT(type: :radio, name: "sex", value: 0, class: 'form-control').on(:change) do |e|
        mutate.sex e.target.value
      end
      LABEL {'women'}
      INPUT(type: :radio, name: "sex", value: 1, class: 'form-control').on(:change) do |e|
        mutate.sex e.target.value
      end
      LABEL {'other'}
      INPUT(type: :radio, name: "sex", value: 2, class: 'form-control').on(:change) do |e|
        mutate.sex e.target.value
      end
    end

    DIV(class: 'div-tel') do
      LABEL {'tel: '}
      INPUT(type: :text, class: 'form-control').on(:change) do |e|
        mutate.tel e.target.value
      end
    end

    DIV(class: 'div-e-mail') do
      LABEL {'e-mail: '}
      INPUT(type: :text, class: 'form-control').on(:change) do |e|
        mutate.email e.target.value
      end
    end

    DIV(class: 'div-e-mail-2') do
      LABEL {'e-mail(confirmation): '}
      INPUT(type: :text, class: 'form-control').on(:change) do |e|
        mutate.email2 e.target.value
      end
    end

    DIV(class: 'div-address') do
      LABEL {'zipcode: '}
      INPUT(type: :text, class: 'form-control').on(:change) do |e|
        mutate.zipcode e.target.value
      end
      LABEL {'addres: '}
      INPUT(type: :text, class: 'form-control').on(:change) do |e|
        mutate.address e.target.value
      end
    end

    DIV(class: 'div-checkin-date') do
      LABEL {'checkin-date: '}
      INPUT(type: :date, class: 'form-control').on(:change) do |e|
        mutate.check_in e.target.value
      end
      LABEL {'checkout-date: '}
      INPUT(type: :date, class: 'form-control').on(:change) do |e|
        mutate.check_out e.target.value
      end
    end

    DIV(class: 'div-number') do
      LABEL {'number: '}
      INPUT(type: :number, class: 'form-control').on(:change) do |e|
        mutate.number e.target.value
      end
      LABEL {'parking_number: '}
      INPUT(type: :number, class: 'form-control').on(:change) do |e|
        mutate.parking_number e.target.value
      end
    end

    DIV(class: 'div-remark') do
      LABEL {'remark: '}
      TEXTAREA(rows: 10,cols: 60, class: 'form-control').on(:change) do |e|
        mutate.remark e.target.value
      end
    end

    DIV(class: 'form-submit') do
      BUTTON(type: :button, class: 'btn btn-success btn-block') { 'Create an new event' }
        .on(:click) { GetRow.run(
          name: state.name,
          kana: state.kana,
          sex: state.sex,
          tel:  state.tel,
          email: state.email,
          address: state.address,
          check_in: state.check_in,
          check_out: state.check_out,
          number: state.number,
          parking_number: state.parking_number,
          remark: state.remark,
        )}
      end
    end
end

class GetRow < Hyperloop::Operation

  param :name
  param :kana
  param :sex
  param :tel
  param :email
  param :address
  param :check_in
  param :check_out
  param :number
  param :parking_number
  param :remark

  step {HTTP.post(
    '/sheet1/create',
    payload: {
      name: params.name,
      kana: params.kana,
      sex: params.sex,
      tel: params.tel,
      email: params.email,
      address: params.address,
      check_in: params.check_in,
      check_out: params.check_out,
      number: params.number,
      parking_number: params.parking_number,
      remark: params.remark,
    }.to_json)}
end
