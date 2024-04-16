# Phone configuration
json.loadAlternateLang true
json.enableAccountSettings false
json.voiceMailSubscribe false
json.hostingPrefix '/powerphone-assets/'
json.uiMaxWidth 9999
json.enableTextMessaging false
json.enableVideoCalling false

# IPBX configuration
json.serverPath @configuration.wss_path
json.sipDomain @configuration.sip_domain
json.wssServer @configuration.wss_server
json.webSocketPort @configuration.wss_port

# Registration configuration
json.profileId @sip_user.profile_id
json.profileName @sip_user.profile_name
json.sipUsername @sip_user.extension
json.sipPassword @sip_user.password
