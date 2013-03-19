module StaticPagesHelper
  def mini_btn(text)
    render(:inline => "<a href='#' class='btn btn-mini btn-info'>#{text}</a>")
  end
end
