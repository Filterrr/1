proxy-providers:
  fx:
    type: http
    url: https://wocf.212124.xyz/Filterrr/1/main/modes/fx
    interval: 6048000
    health-check:
      enable: true
      interval: 720
      url: https://www.gstatic.com/generate_204

  baidu:
    type: http
    url: https://wocf.212124.xyz/Filterrr/1/main/modes/baidu
    interval: 6048000
    override:
      additional-prefix: "【百度直连】"
    health-check:
      enable: true
      interval: 720
      url: https://www.gstatic.com/generate_204

  xiaopro0:
    type: http
    url: https://cfno1.212124.xyz/clash?host=vmypq.212124.xyz&uuid=1705452e-5113-4633-a973-18ea15a1a5f0&path=1705452e&protocol=vmess
    interval: 6048000
    override:
      additional-prefix: "【1】"
      dialer-proxy: 🚀 国内->百度节点
    health-check:
      enable: true
      interval: 720
      url: https://www.gstatic.com/generate_204

  xiaopro1:
    type: http
#    url: https://ed.212124.xyz/api/sub?host=vmypq.212124.xyz&uuid=1705452e-5113-4633-a973-18ea15a1a5f0&path=1705452e&type=vmess
    url: https://api.dler.io/sub?target=clash&new_name=true&url=https%3A%2F%2Fed.212124.xyz%2Fapi%2Fsub%3Fhost%3Dvmypq.212124.xyz%26uuid%3D1705452e-5113-4633-a973-18ea15a1a5f0%26path%3D1705452e%26type%3Dvmess&insert=false&config=https%3A%2F%2Fwocf.212124.xyz%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini&emoji=true&list=true&tfo=false&scv=false&fdn=false&sort=false
    interval: 6048000
    override:
      additional-prefix: "【2】"
      dialer-proxy: 🚀 国内->百度节点
    health-check:
      enable: true
      interval: 720
      url: https://www.gstatic.com/generate_204

#--------------------------------------------------------------------------------------------------------------------------------------

mixed-port: 7890
allow-lan: true
bind-address: "*"
mode: rule
log-level: debug
ipv6: false
geodata-loader: standard
keep-alive-interval: 15
global-client-fingerprint: firefox
find-process-mode: strict
unified-delay: true
tcp-concurrent: true

dns:
  enable: true
  ipv6: false
  listen: 0.0.0.0:1053
  enhanced-mode: fake-ip
  fake-ip-range: 28.0.0.1/8
  default-nameserver:
    - https://223.5.5.5/dns-query
    - https://8.8.8.8/dns-query
  nameserver:
    - https://223.5.5.5/dns-query
    - https://1.0.0.1/dns-query

geodata-mode: true
geo-auto-update: true
geo-update-interval: 24
geox-url:
  geoip: "https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.dat"
  geosite: "https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geosite.dat"
  mmdb: "https://fastly.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@release/geoip.metadb"
  asn: "https://gi.212124.xyz/xishang0128/geoip/releases/download/latest/GeoLite2-ASN.mmdb"

CF: &CF
    type: vless
    uuid: 97e9e73d-2a29-4a1e-b451-093d81c51f7b
    tls: true
    servername: word.212124.xyz
    network: ws
    ws-opts: 
      path: /xkaopf15da
      headers: 
        Host: word.212124.xyz
        
proxies:
  - name: 备用节点1
    server: www.gov.se
    port: 443
    <<: *CF

  - name: 备用节点2
    server: www.visa.com.hk
    port: 8443
    <<: *CF

proxy-groups:
  - name: 🌎 全球节点
    type: select
    proxies:
      - 🚀 国内->百度节点
      - 🌥️ 备用节点
      - ⚠️ UDP策略
    use:
      - xiaopro0
      - xiaopro1
    exclude-filter: "(?i)tg|channel|undefined|t.me"

  - name: 🚀 国内->百度节点
    type: select
    proxies:
      - DIRECT
    use:
      - baidu
      - fx

  - name: ⚠️ UDP策略
    type: select
    proxies:
      - REJECT
      - DIRECT

  - name: 🌥️ 备用节点
    type: url-test
    proxies:
      - 备用节点1
      - 备用节点2
    url: https://www.gstatic.com/generate_204
    interval: 720
    dialer-proxy: 🚀 国内->百度节点

rule-providers:
  ASNChina:
    type: http
    path: ./ruleset/ASNChina.yaml
    url: "https://wocf.212124.xyz/VirgilClyne/GetSomeFries/main/ruleset/ASN.China.yaml"
    interval: 864000
    behavior: classical
    format: yaml

rules:
# UDP 规则 
  - NETWORK,UDP,⚠️ UDP策略
# 广告过滤
  - geosite,category-ads-all,REJECT
# 蓝奏云规则
  - DST-PORT,446,🌎 全球节点
# AI 规则
# ChatGPT
  - DOMAIN-KEYWORD,chat,🌥️ 备用节点
  - DOMAIN,chat.openai.com.cdn.cloudflare.net,🌥️ 备用节点
  - DOMAIN,o33249.ingest.sentry.io,🌥️ 备用节点
  - DOMAIN,openaiapi-site.azureedge.net,🌥️ 备用节点
  - DOMAIN,openaicom-api-bdcpf8c6d2e9atf6.z01.azurefd.net,🌥️ 备用节点
  - DOMAIN,openaicom.imgix.net,🌥️ 备用节点
  - DOMAIN,openaicomproductionae4b.blob.core.windows.net,🌥️ 备用节点
  - DOMAIN,production-openaicom-storage.azureedge.net,🌥️ 备用节点
  - DOMAIN-SUFFIX,chatgpt.com,🌥️ 备用节点
  - DOMAIN-SUFFIX,oaistatic.com,🌥️ 备用节点
  - DOMAIN-SUFFIX,oaiusercontent.com,🌥️ 备用节点
  - DOMAIN-SUFFIX,openai.com,🌥️ 备用节点
# Copilot
  - DOMAIN,api.githubcopilot.com,🌥️ 备用节点
  - DOMAIN,copilot-proxy.githubusercontent.com,🌥️ 备用节点
  - DOMAIN,copilot.microsoft.com,🌥️ 备用节点
  - DOMAIN,sydney.bing.com,🌥️ 备用节点
  - DOMAIN,www.bing.com,🌥️ 备用节点
# Gemini
  - DOMAIN,bard.google.com,🌥️ 备用节点
  - DOMAIN,gemini.google.com,🌥️ 备用节点
  - DOMAIN,generativelanguage.googleapis.com,🌥️ 备用节点
  - DOMAIN,ai.google.dev,🌥️ 备用节点
  - DOMAIN,aida.googleapis.com,🌥️ 备用节点
  - DOMAIN,aistudio.google.com,🌥️ 备用节点
  - DOMAIN,alkalimakersuite-pa.clients6.google.com,🌥️ 备用节点
  - DOMAIN,makersuite.google.com,🌥️ 备用节点
# Claude
  - DOMAIN-SUFFIX,anthropic.com,🌥️ 备用节点
  - DOMAIN-SUFFIX,claude.ai,🌥️ 备用节点
  - IP-CIDR,160.79.104.0/23,🌥️ 备用节点
  - IP-CIDR6,2607:6bc0::/48,🌥️ 备用节点
# JetBrains AI
  - DOMAIN-SUFFIX,grazie.ai,🌥️ 备用节点
  - DOMAIN-SUFFIX,grazie.aws.intellij.net,🌥️ 备用节点
# Meta
  - DOMAIN,imagine.meta.com,🌥️ 备用节点
  - DOMAIN-SUFFIX,meta.ai,🌥️ 备用节点
# 分流规则
  - IN-TYPE,INNER,🌥️ 备用节点
# 国内外分流规则
  - RULE-SET,ASNChina,🚀 国内->百度节点
  - GEOSITE,CN,🚀 国内->百度节点
  - GEOIP,CN,🚀 国内->百度节点
# 兜底规则
  - MATCH,🌎 全球节点
