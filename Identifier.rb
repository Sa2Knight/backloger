require 'backlog_kit'

class Identifier

  def initialize(client)
    @client = client
  end

  def user(userName)
    user = @client.get_users.body.find do |u|
      u.name == userName
    end
    user.id
  end

  def project(projectKey)
    project = @client.get_projects.body.find do |pb|
      pb.projectKey == projectKey
    end
    project.id
  end

  def priority(label)
    priority = @client.get_priorities.body.find do |pr|
      pr.name == label
    end
    priority.id
  end

  def issueType(project_key, label)
    type = @client.get_issue_types(project_key).body.find do |it|
      it.name == label
    end
    type.id
  end

  def status(label)
    status = @client.get_statuses.body.find do |st|
      st.name == label
    end
    status.id
  end

  def resolution(label)
    resolution = @client.get_resolutions.body.find do |res|
      res.name == label
    end
    resolution.id
  end

end
