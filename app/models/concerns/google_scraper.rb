class GoogleScraper
  URL = 'https://www.google.com/search'
  # TOP_AD_LINKS           = '._Ak#_Ltg' # ad-items
  # BOTTON_AD_CONTAINER_ID = '#tads'
  # BOTTOM_AD_LINK_CLASS   = '._WGK'
  # RESULT_STAT_ID         = '#resultStats' # About 6,130,000 results (0.95 seconds)

  attr_accessor :keyword, :report

  def initialize(keyword, report_id)
    @report  = Report.find(report_id)
    @keyword = keyword
  end

  def perform
    report.search_results.create(data_hash)
  end

  private

  # @return [String] Response from the HTTP request
  def http_request
    uri       = URI(URL)
    uri.query = URI.encode_www_form({
                                        q:    keyword,
                                        # sourceid: 'chrome-psyapi2',
                                        ion:  1,
                                        espv: 2,
                                        ie:   'UTF-8'
                                    }) #, aqs: 'chrome..69i57.204j0j4', sourceid: 'chrome', ie: 'UTF-8'
    req       = Net::HTTP::Get.new(uri)
    res       = HTTParty.get(uri.to_s, headers: {
        'Referer'    => "https://www.google.com",
        'User-Agent' => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
        'Cookie'     => '' }).body
  end

  def data_hash
    http_response = http_request

    response_dom                        = Nokogiri::HTML(http_response)
    total_adwords_advertisers_at_top    = response_dom.search('._Ak#_Ltg .ads-ad').count
    # total_adwords_advertisers_at_bottom = response_dom.search('._Ak#_Ktg').count
    adwords_links_at_bottom             = response_dom.search('[data-jibp="h"] ._WGk').map { |x| x.children.text }
    total_adwords_advertisers_at_bottom = adwords_links_at_bottom.count
    number_of_results                   = response_dom.css('#resultStats').first.content.split('About')[1].split('results')[0].delete(',').to_i
    adwords_links_at_top                = response_dom.search('._Ak#_Ltg .ads-ad .ads-visurl cite').map { |x| x.text }
    non_adwords_links                   = response_dom.search('.r a').map { |x| x.attributes['href'].value }
    total_non_adwords_links             = non_adwords_links.count
    total_count_of_links                = total_non_adwords_links + total_adwords_advertisers_at_bottom + total_adwords_advertisers_at_top

    {
        total_adwords_advertisers_at_top:    total_adwords_advertisers_at_top,
        adwords_links_at_bottom:             adwords_links_at_bottom,
        total_adwords_advertisers_at_bottom: total_adwords_advertisers_at_bottom,
        total_number_of_records:             number_of_results,
        adwords_links_at_top:                adwords_links_at_top,
        non_adwords_links:                   non_adwords_links,
        total_non_adwords_links:             total_non_adwords_links,
        total_count_of_links:                total_count_of_links,
        page_cache:                          http_response.encode('UTF-8'),
        status:                              :done,
        keyword:                             keyword
    }
  end
end