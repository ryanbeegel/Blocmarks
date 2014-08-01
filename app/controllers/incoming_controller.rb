class IncomingController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create]


# INCOMING PARAMS HERE: {"recipient"=>"dude@sandbox87fbdbb2803a4f098312c4000103f5f9.mailgun.org", "sender"=>"chris.beck@me.com", "subject"=>"#test", "from"=>"Christopher Beck <chris.beck@me.com>", "X-Envelope-From"=>"<chris.beck@me.com>", "Received"=>"from [10.0.0.3] (unknown [71.204.3.218]) by st11p05mm-asmtp002.mac.com (Oracle Communications Messaging Server 7u4-27.10(7.0.4.27.9) 64bit (built Jun 6 2014)) with ESMTPSA id <0N9F00JDSLHFBP30@st11p05mm-asmtp002.mac.com> for dude@sandbox87fbdbb2803a4f098312c4000103f5f9.mailgun.org; Mon, 28 Jul 2014 16:51:16 +0000 (GMT)", "X-Proofpoint-Virus-Version"=>"vendor=fsecure engine=2.50.10432:5.12.52,1.0.14,0.0.0000 definitions=2014-07-28_02:2014-07-28,2014-07-28,1970-01-01 signatures=0", "X-Proofpoint-Spam-Details"=>"rule=notspam policy=default score
# =0 spamscore=0 suspectscore=6 phishscore=0 adultscore=0 bulkscore=1 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1407280198", "From"=>"Christopher Beck <chris.beck@me.com>", "Content-Type"=>"text/plain; charset=\"us-ascii\"", "Content-Transfer-Encoding"=>"7bit", "Subject"=>"#test", "Message-Id"=>"<75AC2281-8F9B-4B5C-82D3-88322BC341FC@me.com>", "Date"=>"Mon, 28 Jul 2014 12:51:15 -0400", "To"=>"dude@sandbox87fbdbb2803a4f098312c4000103f5f9.mailgun.org", "Mime-Version"=>"1.0 (Mac OS X Mail 7.3 \\(1878.2\\))", "X-Mailer"=>"Apple Mail (2.1878.2)", "X-Mailgun-Incoming"=>"Yes", "message-headers"=>"[[\"X-Envelope-From\", \"<chris.beck@me.com>\"], [\"Received\", \"from st11p05mm-asmtp002.mac.com (st11p05mm-asmtp002.mac.com [17.172.108.250]) by mxa.mailgun.org with ESMTP id 53d67f8e.7f7580437870-in1; Mon, 28 Jul 2014 16:51:26 -0000 (UTC)\"], [\"Received\", \"from [10.0.0.3] (unknown [71.204.3.218]) by st11p05mm-asmtp002.mac.com (Oracle Communications Messaging Server 7u4-27.10(7.0.4.27.9) 64bit (built Jun 6 2014)) with ESMTPSA id <0N9F00JDSLHFBP30@st11p05mm-asmtp002.mac.com> for dude@sandbox87fbdbb2803a4f098312c4000103f5f9.mailgun.org; Mon, 28 Jul 2014 16:51:16 +0000 (GMT)\"], [\"X-Proofpoint-Virus-Version\", \"vendor=fsecure engine=2.50.10432:5.12.52,1.0.14,0.0.0000 definitions=2014-07-28_02:2014-07-28,2014-07-28,1970-01-01 signatures=0\"], [\"X-Proofpoint-Spam-Details\", \"rule=notspam policy=default score=0 spamscore=0 suspectscore=6 phishscore=0 adultscore=0 bulkscore=1 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1407280198\"], [\"From\", \"Christopher Beck <chris.beck@me.com>\"], [\"Content-Type\", \"text/plain; charset=\\\"us-ascii\\\"\"], [\"Content-Transfer-Encoding\", \"7bit\"], [\"Subject\", \"#test\"], [\"Message-Id\", \"<75AC2281-8F9B-4B5C-82D3-88322BC341FC@me.com>\"], [\"Date\", \"Mon, 28 Jul 2014 12:51:15 -0400\"], [\"To\", \"dude@sandbox87fbdbb2803a4f098312c4000103f5f9.mailgun.org\"], [\"Mime-Version\", \"1.0 (Mac OS X Mail 7.3 \\\\(1878.2\\\\))\"], [\"X-Mailer\", \"Apple Mail (2.1878.2)\"], [\"X-Mailgun-Incoming\", \"Yes\"]]", "timestamp"=>"1406566288", "token"=>"0f98750fc97e1a39a1fe67d47b790bb7f51f1f47006aa09da8", "signature"=>"8661213c6ffd9b5d068cdadd141d21650a8d0f102068b7a4376017f6697ed0f1", "body-plain"=>"http://google.com\r\n\r\n", "stripped-html"=>"<p>http://google.com</p>", "stripped-text"=>"http://google.com", "stripped-signature"=>"", "action"=>"create", "controller"=>"incoming"}

# "stripped-text"=>"http://google.com"
# "sender"=>"chris.beck@me.com"
# "subject"=>"#test"

  def create
    user = User.find_by_email(params[:sender])
    if user
      bookmark = Bookmark.find_or_create_by(url: params["stripped-text"])
      user_bookmark = UserBookmark.create(user: user, bookmark: bookmark)

      hashtags = params[:subject].scan(/#\w+/)
      hashtags.each do |hashtag|
        hashtag.sub!('#','')
        topic = Topic.find_or_create_by(name: hashtag)
        topic_bookmark = TopicBookmark.create(topic: topic, bookmark: bookmark)
      end
    end

    HEAD 200
  end
end
