require 'backlog_kit'
require_relative 'Identifier'

class Backlog

  def initialize(client)
    @client = client
    @identifier = Identifier.new(client)
  end

  # 自信が担当になっており、完了していない課題の一覧を取得
  def showIncompleteMyIssues(projectName, userName)
    issues = @client.get_issues({
      :projectId => [@identifier.project(projectName)],
      :assigneeId => [@identifier.user(userName)],
      :statusId => [
        @identifier.status('未対応'),
        @identifier.status('処理中'),
        @identifier.status('処理済み'),
      ]
    })
    issues.body.select { |i| i.summary }
  end

end
