require 'backlog_kit'

class Identifier

  def initialize(client)
    @client = client
  end

  def projectId(projectKey)
    project = @client.get_projects.body.find do |pb|
      pb.projectKey == projectKey
    end
    project.id
  end

  def priorities(label)
    priority = @client.get_priorities.body.find do |pr|
      pr.name == label
    end
    priority.id
  end

  def issueTypeId(project_key, label)
    type = @client.get_issue_types(project_key).body.find do |it|
      it.name == label
    end
    type.id
  end
end
