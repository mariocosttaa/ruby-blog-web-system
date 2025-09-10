module Panel::CommentsHelper
  def comment_status_badge(comment)
    if comment.status
      content_tag(:span, 
        content_tag(:svg, "", class: "w-2 h-2 mr-1", fill: "currentColor", viewBox: "0 0 20 20") do
          content_tag(:path, "", fill_rule: "evenodd", d: "M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z", clip_rule: "evenodd")
        end + "Show",
        class: "inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium border border-green-200 text-green-700",
        style: "background-color: #f0fdf4;"
      )
    else
      content_tag(:span,
        content_tag(:svg, "", class: "w-2 h-2 mr-1", fill: "currentColor", viewBox: "0 0 20 20") do
          content_tag(:path, "", fill_rule: "evenodd", d: "M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z", clip_rule: "evenodd")
        end + "Unshow",
        class: "inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium border border-red-200 text-red-700",
        style: "background-color: #fef2f2;"
      )
    end
  end

  def comment_author_info(comment)
    content_tag(:div, class: "text-xs text-secondary flex items-center") do
      content_tag(:svg, "", class: "w-3 h-3 mr-1", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
        content_tag(:path, "", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z")
      end + comment.name
    end
  end

  def comment_email_info(comment)
    content_tag(:div, class: "text-xs text-secondary flex items-center") do
      content_tag(:svg, "", class: "w-3 h-3 mr-1", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
        content_tag(:path, "", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z")
      end + comment.email
    end
  end
end
