defmodule Felix.Myself do
  def info do
    %{
      first_name: "Teerawat",
      last_name: "Lamanchart",
      bio: "I love coding and learning new things",
      country: "Thailand",
      education: education(),
      experience: experience(),
      skills: skills(),
      languages: languages(),
    }
  end

  defp education do
    [
      %{
        school: "King Mongkut's Institute of Technology Ladkrabang",
        degree: "Bachelor's degree",
        field_of_study: "Electrical Engineering",
      }
    ]
  end

  defp experience do
    [
      %{
        title: "Software developer",
        company: "Omise",
        from: "Sep 2015",
        to: "Present",
      },

      %{
        title: "Software developer",
        company: "Nimbl3",
        from: "Mar 2015",
        to: "Aug 2015",
      },

      %{
        title: "Technical Support Analyst",
        company: "Greenline Synergy",
        from: "Jun 2014",
        to: "Feb 2015",
      },
    ]
  end

  defp skills do
    [
      "Ruby",
      "Ruby on Rails",
      "Elixir",
      "Phoenix",
      "Elm",
      "Web Applications",
      "Databases",
    ]
  end

  defp languages do
    [
      "Thai",
      "English",
    ]
  end
end
