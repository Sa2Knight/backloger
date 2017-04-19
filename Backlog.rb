require 'backlog_kit'
require_relative 'Identifier'

class Backlog

  def initialize(client, projectName, userName)
    @client = client
    @identifier = Identifier.new(client)
    @projectId = @identifier.project(projectName)
    @userId = @identifier.user(userName)
  end

  # 自信が担当になっており、完了していない課題の一覧を取得
  def showIncompleteMyIssues
    issues = @client.get_issues({
      :projectId => [@projectId],
      :assigneeId => [@userId],
      :statusId => [
        @identifier.status('未対応'),
        @identifier.status('処理中'),
        @identifier.status('処理済み'),
      ]
    })
    issues.body
  end

end
