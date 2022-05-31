class User < ApplicationRecord
    # モデル名以外を関連名(created_events)を指定したのでclass_nameを指定する。
    # 外部キーもデフォルトのuser_idでないのでforeign_keyで指定する。
    has_many :created_events, class_name: "Event", foreign_key: "owner_id"

    # <Hashie::Array []> raw_info=#<OmniAuth::AuthHash avatar_url="https://avatars.githubusercontent.com/u/72182214?v=4" bio=nil blog="" company=nil created_at="2020-10-01T04:25:20Z" email=nil events_url="https://api.github.com/users/zabrak002/events{/privacy}" followers=0 followers_url="https://api.github.com/users/zabrak002/followers" following=0 following_url="https://api.github.com/users/zabrak002/following{/other_user}" gists_url="https://api.github.com/users/zabrak002/gists{/gist_id}" gravatar_id="" hireable=nil html_url="https://github.com/zabrak002" id=72182214 location=nil login="zabrak002" name=nil node_id="MDQ6VXNlcjcyMTgyMjE0" organizations_url="https://api.github.com/users/zabrak002/orgs" public_gists=0 public_repos=4 received_events_url="https://api.github.com/users/zabrak002/received_events" repos_url="https://api.github.com/users/zabrak002/repos" site_admin=false starred_url="https://api.github.com/users/zabrak002/starred{/owner}{/repo}" subscriptions_url="https://api.github.com/users/zabrak002/subscriptions" twitter_username=nil type="User" updated_at="2022-05-27T02:35:41Z" url="https://api.github.com/users/zabrak002"> scope=""> info=#<OmniAuth::AuthHash::InfoHash email=nil image="https://avatars.githubusercontent.com/u/72182214?v=4" name=nil nickname="zabrak002" urls=#<OmniAuth::AuthHash Blog="" GitHub="https://github.com/zabrak002">> provider="github" uid="72182214">
    # User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."provider" = ? AND "users"."uid" IS NULL LIMIT ?  [["provider", "github"], ["LIMIT", 1]]
    def self.find_or_create_from_auth_hash!(auth_hash)
        Rails.logger.info(auth_hash)
        provider = auth_hash[:provider]
        uid = auth_hash[:uid]
        nickname = auth_hash[:info][:nickname]
        image_url = auth_hash[:info][:image]

        # providerとuidでunique
        User.find_or_create_by!(provider: provider, uid: uid) do |user|
            user.name = nickname
            user.image_url = image_url
        end
    end
end
