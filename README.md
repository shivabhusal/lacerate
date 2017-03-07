# README

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
  - It is recommended by experts to keep minimum pause/gap of 5 seconds in between two consecutive query
- Set Your Referrer URL 
- Create Unique User Agents for your Proxies 

#### Speeding up searches 
(talking about thousands of keywords)  
When there are thousands of keywords you need to take care of, employing a single server(IP) to query with necessary pauses will be pretty time consuming. So, best way is to 
- employ additional servers to crawl via the internet.
- get rid of duplicate keywords
- It also requires you to evenly distribute the keywords so that no re-work occurs and all workers complete around the same time.

### Tools used
  * Ruby: `ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux]`
  * Rails: `Rails 5.0.2` 
    
### System dependencies
  * PG Database
  * Redis for Sidekiq

### Configuration
  * see the `application.yml.sample` for sample environment variables with dummy data.

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
