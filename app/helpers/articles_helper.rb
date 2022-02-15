module ArticlesHelper
  require "redcarpet"
  require "coderay"

  # 変更画面でのタグの初期値
  def getTagNamesStr(tags)
    tags.pluck(:name).join(' ')
  end

  # マークダウン対応
  def markdown(text)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)

    options = {
      autolink: true,
      space_after_headers: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      xhtml: true,
      lax_html_blocks: true,
      strikethrough: true,
    }
    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(text)
  end

  # 言語での記述（シンタックスハイライト）の導入（coderay）
  class HTMLwithCoderay < Redcarpet::Render::HTML
    # header設定
    def header(text, level)
      case level
      when 1
        "<h#{level} class=\"text-3xl border-b mb-2\">#{text}</h#{level}>"
      when 2
        "<h#{level} class=\"text-2xl border-b mb-2\">#{text}</h#{level}>"
      when 3
        "<h#{level} class=text-xl>#{text}</h#{level}>"
      else
        "<h3 class=\"text-xl mb-2\">#{text}</h3>"
      end
    end

    def block_code(code, language)
      language = language ? language.split(":")[0] : ""

      case language.to_s
      when "rb"
        lang = "ruby"
      when "yml"
        lang = "yaml"
      when "css"
        lang = "css"
      when "html"
        lang = "html"
      when ""
        lang = "md"
      else
        lang = language
      end

      # tailwindクラスをつけたいのでCodeRayをdivで囲んで返す
      result = "<div class=\"bg-gray-200 px-2 mb-2\">#{CodeRay.scan(code, lang).div}</div>"
      return result
    end
  end
end
