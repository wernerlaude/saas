module ApplicationHelper
  # Link, der sich selbst als aktuelle Seite markiert (aria-current="page").
  # Das CSS stylt über [aria-current] – keine extra "active"-Klasse nötig.
  def nav_link_to(name, path, **options)
    current = path != "#" && current_page?(path)
    link_to name, path, **options, "aria-current": (current ? "page" : nil)
  end
end
