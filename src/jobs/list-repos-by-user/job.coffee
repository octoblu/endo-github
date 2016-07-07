Github = require 'github'
http   = require 'http'
_      = require 'lodash'

class ListReposByUser
  constructor: ({@encrypted}) ->
    @github = new Github
    @github.authenticate type: 'oauth', token: @encrypted.secrets.credentials.secret


  do: ({data}, callback) =>
    return callback @_userError(422, 'data is required') unless data?
    return callback @_userError(422, 'data.username is required') unless data.username?

    @github.repos.getForUser {user: data.username}, (error, results) =>
      return callback error if error?
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
        data: @_processResults results
      }

  _processResult: (result) =>
    {
      repoName:         result.full_name
    }

  _processResults: (results) =>
    _.map results, @_processResult

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = ListReposByUser
