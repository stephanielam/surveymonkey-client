require 'surveymonkey/client/version'
require 'httparty'

module Surveymonkey
  SurveymonkeyError = Class.new(StandardError)

  class Client
    attr_reader :api_key, :access_token

    API_URL = 'https://api.surveymonkey.net/v2/'

    PAGINATED_METHODS = {
      'surveys/get_survey_list'     => 'surveys',
      'surveys/get_respondent_list' => 'respondents'
    }

    def initialize(api_key, access_token)
      @api_key = api_key
      @access_token = access_token
    end

    def user(options = '')
      body = {}

      get_request('user/get_user_details', body, options)['data']
    end

    def surveys(options = '')
      body = { :fields => ['title'] }

      paginate_request('surveys/get_survey_list', body, options)
    end

    def survey_details(survey_id, options = '')
      body = { :survey_id => survey_id }.to_json

      get_request('surveys/get_survey_details', body, options)['data']
    end

    def respondents(survey_id, options = '')
      body = {
        :survey_id => survey_id,
        :fields => ['email', 'first_name', 'last_name']
      }

      paginate_request('surveys/get_respondent_list', body, options)
    end

    def responses(survey_id, respondent_ids, options = '')
      body = {
        :survey_id => survey_id,
        :respondent_ids => respondent_ids,
        :fields => ['email', 'first_name', 'last_name']
      }.to_json

      get_request('surveys/get_responses', body, options)['data']
    end

    private

    def uri_generator(endpoint, options = '')
      "#{API_URL}#{endpoint}?api_key=#{@api_key}"
    end

    def get_request(endpoint, body, options = '')
      response =
        HTTParty.post(uri_generator(endpoint, options),
                       :headers => {
                         'Authorization' => "bearer #{@access_token}",
                         'Content-Type' => 'application/json'
                       },
                       :body => body
                     )

      if response['status'] != 0
        raise SurveymonkeyError, response
      else
        response
      end
    end

    def paginate_request(endpoint, body, options)
      all_resources = []
      current_page = 1

      loop do
        body[:page] = current_page
        response = get_request(endpoint, body.to_json, options)

        break if response['data'][PAGINATED_METHODS[endpoint]].empty?
        if response['status'] == 0
          all_resources += response['data'][PAGINATED_METHODS[endpoint]]
          current_page += 1
        end
      end

      all_resources
    end

  end
end
