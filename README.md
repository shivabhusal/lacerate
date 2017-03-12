# README
[![CircleCI](https://circleci.com/gh/shivabhusal/lacerate.svg?style=svg)](https://circleci.com/gh/shivabhusal/lacerate)
[![Code Climate](https://lima.codeclimate.com/github/shivabhusal/lacerate/badges/gpa.svg)](https://lima.codeclimate.com/github/shivabhusal/lacerate)  

---

Lacerate is an OpenSource Rails application under [MIT License](https://opensource.org/licenses/MIT). Lacerate basically takes keywords in a CSV file, scrapes Google and extracts useful information to generate analytics and report for business and SEO analysis.

### Info we extract from google
- Number of AdWords advertisers in the top position.
- Number of AdWords advertisers in the bottom position.
- Total number of AdWords advertisers on the page.
- Display URLs (in green) of the AdWords advertisers in the top position.
- Display URLs (in green) of the AdWords advertisers in the right side position.
- Number of the non-AdWords results on the page.
- URLs of the non-AdWords results on the page.
- Total number of links (all of them) on the page
- Total of search results for this keywords e.g. About 21,600,000 results (0.42 seconds) 
- HTML code of the page/cache of the page.

### Technical challenges
#### Preventing Banning IP
Google lets normal user to search queries as much they like, however, they don't like bots goofing around the site. So, suspecious activity can get our IP blacklisted for future access. So, we should not let that happen. Imitating human search patterns is the only way to get unnoticed by Google's bot detection algorithm. Things we gonna try are:- 

- Set a Query Rate Limit
  - It is recommended by experts to keep minimum pause/gap of 2 seconds in between two consecutive queries.
- Set Your Referrer URL
  - since a genuine request(like a human user) start from `google.com` and then search begins; like wise, need to set referral of that web request to `google.com` or something.
- Create Unique User Agents for your Proxies 
  - familiar user agent like google chrome to make believe google that this request is originated from user's browser.

#### Speeding up searches 
(talking about thousands of keywords)  
When there are thousands of keywords you need to take care of, employing a single server(IP) to query with necessary pauses will be pretty time consuming. So, best way is to 
- employ additional servers to crawl via the internet.
    - for the purpose, have planned to use 5 different heroku servers/dynos with separate IP 
        - they will be using the same Redis instance via connection pool.
        - they will be using the same PG-Database as they are the part of the same system.
- get rid of duplicate keywords  
- It also requires you to evenly distribute the keywords so that no re-work occurs and all workers complete around the same time.
    - turns out, you will just have to assign jobs in sidekiq; since all the sidekiq instances share the same `Redis` instance, they will pick jobs from the default queues and execute. In this way by the end of execution, all the workers will have completed almost equal number of jobs.

### For maintainers
- adding new elements
  - If you need to add view elements as per new features, you can see all the visual elements from our already setup style-guides. This style guide will only appear in development environment; an extra menu-item in the sidebar will appear called "UI Elements/Style Guide". You can then either copy the code(in SLIM) from `views/style_guides/*.slim` or write it your self. It is supposed to make code consistent and speed up development.

### Tools used
  * Ruby: `ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]`
  * Rails: `Rails 5.0.2` 
  * ActiveModel::Searilizer
    - ActiveModel::Serializer allows you to define which attributes and relationships you would like to include in your JSON response. It also acts as a presenter where you can define custom methods to display extra information or override how it’s displayed in your JSON.
    
### Known issues:
- **Responsiveness of Charts**
    - It appears perfect no matter which device you load it from. However, if you load in wider screens and then Zoom-In, you might encounter overflow.
    - But if you zoom-in and refresh the page, it should apepar just fine.
    - **Issue:** Chart does not re-render when you resize the window.
### System dependencies
  * PG Database
  * Redis for Sidekiq

### Configuration
  * see the `application.yml.sample` for sample environment variables with dummy data.
  
### API documentation
  * Api is well documented and mounted to `http://host:post/dev/v1`
  * For production: ``
  * Our API documentation is easy to read and conprehensible.
  * If you update the test cases in `spec/acceptance/**/*_spec.rb`, then you will have to run `rails docs:generate`. This will generate the latest API doc in `public/dev/v1`. 
  * **Upside:** Clients will always be able to see the latest version of the document.

### Database creation
  * `rails db:create`

### Database initialization
  * `rails db:setup`

#### How to run the test suite
  * `rspec spec/`

### Services
  * ActiveJob using Sidekiq

### Deployment instructions
  * deploy to heroku using `git push heroku master`

---

Maintainer of this project: Shiva Bhusal
