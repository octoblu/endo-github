Github = require 'github'
http   = require 'http'
_      = require 'lodash'

class ListReposByUser
  constructor: ({@encrypted}) ->
    console.log '@encrypted', JSON.stringify @encrypted
    @github = new Github
      debug: true
    @github.authenticate type: 'oauth', token: @encrypted.secrets.credentials.secret


  do: ({data}, callback) =>
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
      type:             result.type
      repo_name:        result.full_name
      watchers_count:   result.watchers_count
      stargazers_count: result.stargazers_count
      forks_count:      result.forks_count
      open_issues:      result.open_issues
    }

  _processResults: (results) =>
    _.map results, @_processResult

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = ListReposByUser
