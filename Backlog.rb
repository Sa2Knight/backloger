require 'backlog_kit'
require_relative 'Identifier'

class Backlog

  def initialize(client, projectName, userName)
    @client = client
    @identifier = Identifier.new(client)
    @projectId = @identifier.project(projectName)
    @userName = userName
  end

  # 自信が担当になっており、完了していない課題の一覧を取得
  def showIncompleteMyIssues
    issues = @client.get_issues({
      :projectId => [@projectId],
      :assigneeId => [@identifier.user(@userName)],
      :statusId => [
        @identifier.status('未対応'),
        @identifier.status('処理中'),
        @identifier.status('処理済み'),
      ]
    })
    issues.body
  end

  # 課題を新規登録する
  def createIssue(summary, description, type, category, user = @userName)
    @client.create_issue(summary, {
      :projectId => @projectId,
      :description => description,
      :issueTypeId => @identifier.issueType(@projectId, type),
      :categoryId => [@identifier.category(@projectId, category)],
      :priorityId => @identifier.priority('中'),
      :assigneeId => @identifier.user(user),
    })
  end

  # 課題をクローズする
  def closeIssue(key, hour, comment = '')
    @client.update_issue(key, {
      :statusId => @identifier.status('完了'),
      :resolutionId => @identifier.resolution('対応済み'),
      :actualHours => hour,
    })
  end

end
