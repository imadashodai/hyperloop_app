class CreateUser < Hyperloop::Operation

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
