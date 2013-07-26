require "gg_translator/version"

module GgTranslator
  module Joiner
    def joins(s1, s2)
      sub1 = ' ' * s1.map{|s| s.size}.max + '  '
      sub2 = ' ' * s2.map{|s| s.size}.max + '  '
      i = 0
      res = []
      while (i <= s1.size-1 || i <= s2.size-1) do
        res[i] = (s1[i] && s1[i].ljust(sub1.size) or sub1) + (s2[i] && s2[i].ljust(sub2.size) or sub2)
        i+=1
      end
      res
    end
  end

  class Translator
    include Joiner
    require 'rubygems'
    require 'net/http'
    require 'uri'
    require 'json'
    attr_accessor :sl, :tl, :last, :phrase_mode

    def initialize(sl = 'auto', tl = 'ru')
      @sl = sl
      @tl = tl
    end

    def t(text)
      base_url = '/translate_a/t?client=j&pc=0&oc=1&hl=en&ie=UTF-8&oe=UTF-8'
      req = "#{base_url}&text=#{text}&sl=#{@sl}&tl=#{@tl}"
      result = ask_google(req)
      @sl = result['src'] #remember language
      print_result(result)
    end

    def exp(text = nil)
      text.strip!
      text ||= Readline::HISTORY.to_a.last
      text = URI.encode(text)
      req = "/translate_a/ex?sl=#{@sl}&tl=#{@tl}&q=#{text}"
      res = ask_google(req)[0][0]
      res && res.map{|e| [e.first, e[3]]}.each do |s, translation|
        s = s.split(/<b>|<\/b>/)
        puts "#{s[0]}#{s[1].upcase}#{s[2]}"
        s = translation.split(/<b>|<\/b>/)
        puts "#{s[0]}**#{s[1].upcase}**#{s[2]}"
        puts '-'*80
      end
      true
    end

    private
    def ask_google(req)
      proxy = URI.parse(ENV['http_proxy']) if ENV['http_proxy']
      worker = proxy ? Net::HTTP::Proxy(proxy.host, proxy.port) : Net::HTTP
      JSON.parse(worker.get_response('translate.google.com', req).body)
    end

    def print_result(result)
      sentences = []
      result['sentences'].each do |s|
        sentences << "#{s['trans']}"
      end
      puts ''
      puts '-'*80
      puts "#{result['sentences'][0]['orig']}: #{sentences.join(', ')} (#{result['src']})"

      if result['dict']
        s = []
        result['dict'].each_with_index do |d, i|
          s[i] = ["#{d['pos']}: "]
          d['terms'].each_with_index do |t|
            (s[i] ||= []) <<  "- #{t}"
          end
        end

        i = 0
        res = ['']
        while i < s.size do
          if res[0].size > 50
            puts '-' * 80
            puts res
            res = ['']
          end
          res = joins(res, s[i])
          i+=1
        end
        puts '-' * 80
        puts res
      end
    end
  end
end
