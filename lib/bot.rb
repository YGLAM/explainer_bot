require 'telegram/bot'
require_relative 'explain.rb'


class Bot
  def initialize(token)

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        case message.text
        when '/hello'
          bot.api.send_message(chat_id: message.chat.id, text: "Hi #{message.from.first_name},tag @allmyacronyms_bot and type in the chat to look for words you didn't know on the Urban Dictionary")
        end
      when Telegram::Bot::Types::InlineQuery
          list = createParsedList(message.query)
          bot.api.answerInlineQuery(inline_query_id: message.id, results: list)
        end#if
      end#case
    end#do message
  end#do bot
end#def initialize

def createParsedList(query)
  requested = Explain.searchfor(query)
  queryResult = requested["list"]
  list = Array.new
  if ( queryResult.class != NilClass)
    i=0
    queryResult.each do |definition|
      text = Telegram::Bot::Types::InputTextMessageContent.new(message_text: "#{query} :: #{definition.values[0]}")
      article = Telegram::Bot::Types::InlineQueryResultArticle.new(type: "article" , id: "#{i}", title: "Result n.#{i+1} for #{query}", input_message_content: text, description: definition.values[0] )
      list = list.push(article)
      i = i+1
    end#each
  return list
end#def createParsedList
end#all
