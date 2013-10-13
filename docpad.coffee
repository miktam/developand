# =================================
# Misc Configuration

# Prepare
githubAuthString = "client_id=#{process.env.GITHUB_CLIENT_ID}&client_secret=#{process.env.GITHUB_CLIENT_SECRET}"
projects = []
reposGetter = null

# -------------------------------------
# Helpers

getRankInUsers = (users=[]) ->
  rank = null

  for user,index in users
    if user.login is 'balupton'
      rank = String(index+1)
      break

  return rank

suffixNumber = (rank) ->
  rank = String(rank)

  if rank
    if rank >= 1000
      rank = rank.substring(0,rank.length-3)+','+rank.substr(-3)
    else if rank >= 10 and rank < 20
      rank += 'th'
    else switch rank.substr(-1)
      when '1'
        rank += 'st'
      when '2'
        rank += 'nd'
      when '3'
        rank += 'rd'
      else
        rank += 'th'

  return rank

floorToNearest = (value,floorToNearest) ->
  result = Math.floor(value/floorToNearest)*floorToNearest


# =================================
# DocPad Configuration

module.exports =
  regenerateEvery: 1000*60*60  # hour

  # =================================
  # Template Data
  # These are variables that will be accessible via our templates
  # To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

  templateData:
    # Site Data
    site:
      version: require('./package.json').version
      url: "http://developand.com"
      title: "Andrei Karpushonak"
      author: "Andrei Karpushonak"
      email: "andrei@developand.com"
      description: """
        Website of Andrei Karpushonak. Programmer. Available for consulting and training.
        """
      keywords: """
        node.js, javascript, html5, git, nosql, web development, web design, programming, hacking
        """

      text:
        heading: "Andrei Karpushonak"
        subheading: '''
          <t render="html.coffee">
            link = @getPreparedLink.bind(@)
            text """
              Programmer, entrepreneur, father and husband<br/>
              I use #{link 'nodejs'}, #{link 'android'}, #{link 'javascript'}, #{link 'coffeescript'},  #{link 'html5'} and #{link 'opensource'}<br/>
              Available for consulting - #{link 'contact'}
              """
          </t>
          '''
        about: '''
          <t render="html.coffee">
            link = @getPreparedLink.bind(@)
            text """
              This website was created with #{link 'bevry'}’s #{link 'docpad'} and is #{link 'source'}
              """
          </t>
          '''
        copyright: '''
          <t render="html.md">
            Copyright © 2013+ [Andrei Karpushonak](http://developand.com) and licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)
          </t>
          '''

      services:
        twitterTweetButton: "miktam"
        twitterFollowButton: "miktam"
        githubFollowButton: "miktam"
        quoraFollowButton: "Andrei-Karpushonak"
        googleAnalytics: 'UA-42935824-3'

      social:
        """
        devoxx
        twitter
        linkedin
        github
        youtube
        """.trim().split('\n')

      styles: []  # embedded in layout

      scripts: """
        /vendor/jquery-2.0.2.js
        /vendor/fancybox-2.1.5/jquery.fancybox.js
        /scripts/script.js
        """.trim().split('\n')

      feeds: [
          href: 'https://github.com/miktam.atom'
          title: 'GitHub Activity'
        ,
          href: 'https://api.twitter.com/1/statuses/user_timeline.atom?screen_name=miktam&count=20&include_entities=true&include_rts=true'
          title: 'Tweets'
      ]

      links:
        opencollaboration:
          text: 'Open Collaboration'
          url: 'https://github.com/bevry/goopen'
          title: 'Learn more'
        freeculture:
          text: 'Free Culture'
          url: 'http://en.wikipedia.org/wiki/Free_culture_movement'
          title: 'Learn more on Wikipedia'
        docpad:
          text: 'DocPad'
          url: 'http://docpad.org'
          title: 'Visit Website'
        hostel:
          text: 'Startup Hostel'
          url: 'http://startuphostel.org'
          title: 'Visit Website'
        bevry:
          text: 'Bevry'
          url: 'http://bevry.me'
          title: 'Visit Website'
        webwrite:
          text: 'Web Write'
          url: 'https://github.com/webwrite'
          title: 'Visit Website'
        opensource:
          text: 'Open-Source'
          url: 'http://en.wikipedia.org/wiki/Open-source_software'
          title: 'Learn more on Wikipedia'
        html5:
          text: 'HTML5'
          url: 'http://en.wikipedia.org/wiki/HTML5'
          title: 'Learn more on Wikipedia'
        coffeescript:
          text: 'CoffeeScript'
          url: 'http://coffeescript.org'
          title: 'Visit Website'
        javascript:
          text: 'JavaScript'
          url: 'http://en.wikipedia.org/wiki/JavaScript'
          title: 'Learn more on Wikipedia'
        nodejs:
          text: 'Node.js'
          url: 'http://nodejs.org/'
          title: 'Visit Website'
        android:
          text: 'Android'
          url: 'http://www.android.com/'
          title: 'Visit Website'
        balupton:
          text: 'Benjamin Lupton'
          url: 'http://balupton.com'
          title: 'Visit Website'
        author:
          text: 'Andrei Karpushonak'
          url: 'http://developand.com'
          title: 'Visit Website'
        source:
          text: 'open-source'
          url: 'https://github.com/miktam/developand'
          title: 'View Website Source'
        contact:
          text: 'Contact'
          url: 'mailto:andrei@developand.com'
          title: 'Contact me'
          cssClass: 'contact-button'
        devoxx:
          text: 'Devoxx Conference'
          url: 'http://www.devoxx.com/display/DV12/Code+injection+in++Android'
          title: 'Visit presentation'

    # Link Helper
    getPreparedLink: (name) ->
      link = @site.links[name]
      renderedLink = """
        <a href="#{link.url}" title="#{link.title}" class="#{link.cssClass or ''}">#{link.text}</a>
        """
      return renderedLink

    # Meta Helpers
    getPreparedTitle: -> if @document.title then "#{@document.title} | #{@site.title}" else @site.title
    getPreparedAuthor: -> @document.author or @site.author
    getPreparedEmail: -> @document.email or @site.email
    getPreparedDescription: -> @document.description or @site.description
    getPreparedKeywords: -> @site.keywords.concat(@document.keywords or []).join(', ')

    # Ranking Helpers
    suffixNumber: suffixNumber
    floorToNearest: floorToNearest
    getAustraliaJavaScriptRank: ->
      feed = @feedr.feeds['github-australia-javascript']?.users ? null
      return getRankInUsers(feed) or 2
    getAustraliaRank: ->
      feed = @feedr.feeds['github-australia']?.users ? null
      return getRankInUsers(feed) or 4
    getGithubFollowers: (z=50) ->
      followers = @feedr.feeds['github-profile']?.followers or 358
      return followers
    getStackoverflowReputation: (z=1000) ->
      reputation = @feedr.feeds['stackoverflow-profile']?.users?[0]?.reputation ? 10746
      return reputation

    # Project Helpers
    getProjects: ->
      return projects

    # Project Counts
    getGithubCounts: ->
      @githubCounts or= (=>
        projects = @getProjects()
        forks = stars = 0
        total = projects.length

        top = @feedr.feeds['github-top'] ? null
        topData = /\#([0-9]+).+?miktam.+?([0-9]+)/.exec(top)
        rank = topData?[1] or 23
        contributions = topData?[2] or 3582

        for project in projects
          forks += project.forks
          stars += project.watchers

        total or= 136
        forks or= 1057
        stars or= 8024

        return {forks, stars, projects:total, rank, contributions}
      )()


  # =================================
  # Collections

  collections:
    pages: ->
      @getCollection('documents').findAllLive({menuOrder:$exists:true},[menuOrder:1])

    posts: ->
      @getCollection('documents').findAllLive({relativeOutDirPath:'blog'},[date:-1])


  # =================================
  # Events

  events:

    # Fetch Projects
    generateBefore: (opts,next) ->
      # Prepare
      docpad = @docpad

      # Log
      docpad.log('info', 'Fetching your latest projects for display within the website')

      # Prepare repos getter
      reposGetter ?= require('getrepos').create(
        log: docpad.log
        github_client_id: process.env.GITHUB_CLIENT_ID
        github_client_secret: process.env.GITHUB_CLIENT_SECRET
      )

      # Fetch repos
      reposGetter.fetchReposFromUsers ['miktam'], (err,repos=[]) ->
        # Check
        return next(err)  if err

        # Apply
        projects = repos.sort((a,b) -> b.watchers - a.watchers)
        docpad.log('info', "Fetched your latest projects for display within the website, all #{repos.length} of them")

        # Complete
        return next()

      # Return
      return true

    serverExtend: (opts) ->
      # Prepare
      docpadServer = opts.server

      # ---------------------------------
      # Server Configuration

      # Redirect Middleware
      docpadServer.use (req,res,next) ->
        if req.headers.host in ['www.balupton.com','lupton.cc','www.lupton.cc','balupton.no.de','balupton.herokuapp.com']
          res.redirect 301, 'http://balupton.com'+req.url
        else
          next()

      # ---------------------------------
      # Server Extensions

      # Demos
      docpadServer.get /^\/sandbox(?:\/([^\/]+).*)?$/, (req, res) ->
        project = req.params[0]
        res.redirect 301, "http://balupton.github.com/#{project}/demo/"
        # ^ github pages don't have https

      # Projects
      docpadServer.get /^\/projects\/(.*)$/, (req, res) ->
        project = req.params[0] or ''
        res.redirect 301, "https://github.com/miktam/#{project}"

      docpadServer.get /^\/(?:g|gh|github)(?:\/(.*))?$/, (req, res) ->
        project = req.params[0] or ''
        res.redirect 301, "https://github.com/miktam/#{project}"

      # Twitter
      docpadServer.get /^\/(?:t|twitter|tweet)(?:\/(.*))?$/, (req, res) ->
        res.redirect 301, "https://twitter.com/miktam"

      # Sharing Feed
#      docpadServer.get /^\/feeds?\/shar(e|ing)(?:\/(.*))?$/, (req, res) ->
#        res.redirect 301, "http://feeds.feedburner.com/balupton/shared"

      # Feeds
#      docpadServer.get /^\/feeds?(?:\/(.*))?$/, (req, res) ->
#        res.redirect 301, "http://feeds.feedburner.com/balupton"


  # =================================
  # Plugin Configuration

  plugins:
    feedr:
      timeout: 60*1000
      feeds:
        'stackoverflow-profile':
          url: 'http://api.stackoverflow.com/1.0/users/701875/'
        'github-australia-javascript':
          url: "https://api.github.com/legacy/user/search/location:Australia%20language:JavaScript?#{githubAuthString}"
        'github-australia':
          url: "https://api.github.com/legacy/user/search/location:Australia?#{githubAuthString}"
          # https://github.com/search?q=location%3AAustralia&type=Users&s=followers
        'github-top':
          url: 'https://gist.github.com/paulmillr/2657075/raw/active.md'
        'github-profile':
          url: "https://api.github.com/users/miktam?#{githubAuthString}"
        'github':
          url: "https://github.com/miktam.atom"
        'youtube':
          url: "http://gdata.youtube.com/feeds/api/playlists/PLV_7KYLd5XHjELGKriAaAX3altJl4SpQl?alt=json"
