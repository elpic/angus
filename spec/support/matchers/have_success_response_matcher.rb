RSpec::Matchers.define :have_success_response do

  match do |response|
    begin
      @json = JSON(response.body)

      is_valid_response?
    rescue JSON::ParserError => exception
      @error = "Error will parsing response: #{exception.message}"
    end
  end

  description do
    'have success response'
  end

  failure_message_for_should do
    if @error
      @error
    elsif @json && @json['status']
      "expect #{@json['status']} to be success\n#{@json.inspect}"
    else
      "expect #{@json} to include status in it's keys"
    end
  end

  failure_message_for_should_not do
    if @error
      @error
    elsif @json && @json['status']
      "expect #{@json['status']} to not be success\n#{@json.inspect}"
    else
      "expect #{@json} to include status in it's keys"
    end
  end

  def is_valid_response?
    @json && @json['status'] == 'success'
  end
end