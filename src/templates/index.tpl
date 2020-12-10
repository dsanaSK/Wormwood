{#
This template extends the comic.tpl template without making any changes to it, which is the same as just doing
   the exact same thing the comic.tpl template does. This is useful when you want one page to duplicate the
   functionality of another page. In the case of index.tpl, it lets the main landing page for the website be the
   same as the comic page for the latest page that's been uploaded.
The reason it will become the latest comic page and not any other page is that the Python script that generates
    the HTML files from these templates passes only the information for the latest comic page into this file.
    See comic.tpl for a better idea about what values are passed in and how it's built.
If you want the main landing page for your website to look different, this is the file you'll want to edit.
   You can follow the examples of other templates and let the Python script provide values to you (like links to
   the first and last pages of the comic), or you can delete everything and write it in pure HTML. comic_git doesn't
   care!
#}
{% extends "comic.tpl" %}
{%- block content %}
<h1> THIS IS HOME PAGE HEADER</h1>
    {# `super()` means that everything that's currently in the `head` block in base.tpl is added first, and then the
       next line is added to the end. #}
  {#  {{- super() }} #}
  <div>
  Hello!

I'm <b>dSana</b>, a self-taught comic book artist working on MLP:FIM fancomic since 2016, after a chronic sickness forced me to quit my day job and focus on my true vocation - sequential art. I live with my husband in Edinburgh and enjoy slow travels, cooking& reading ^_^
&nbsp; &nbsp;<br><br>
All my SFW stories are available for reading online for free or can be purchased on Gumroad or Ko-fi.
  
  </div>
  
   <div id="comic-page">
        <a href="{{ base_dir }}/comic/{{ first_id }}/#comic-page">
            <img id="comic-image" src="https://dsanask.github.io/comic_git/your_content/images/cover.jpg" title="{{ alt_text }}"/>
        </a>
    </div>

    {# If blocks let you check the value of a variable and then generate different HTML depending on that variable.
       The if block below will generate non-functioning links for `First` and `Previous` if the current page is the
       first page in the comic, and functioning links otherwise. #}
    <div id="navigation-bar">
    {% if first_id == current_id %}
        <a class="navigation-button-disabled">‹‹ First</a>
        <a class="navigation-button-disabled">‹ Previous</a>
    {% else %}
        <a class="navigation-button" href="{{ base_dir }}/comic/{{ first_id }}/#comic-page">‹‹ First</a>
        <a class="navigation-button" href="{{ base_dir }}/comic/{{ previous_id }}/#comic-page">‹ Previous</a>
    {% endif %}
    {# The block below is the same as the one above, except it checks if you're on the last page. #}
    {% if last_id == current_id %}
        <a class="navigation-button-disabled">Next ›</a>
        <a class="navigation-button-disabled">Last ››</a>
    {% else %}
        <a class="navigation-button" href="{{ base_dir }}/comic/{{ next_id }}/#comic-page">Next ›</a>
        <a class="navigation-button" href="{{ base_dir }}/latest/#comic-page">Last ››</a>
    {% endif %}
    </div>

	 
    <div id="blurb">
        <h1 id="page-title">{{ page_title }}</h1>
        <h3 id="post-date">Posted on: {{ post_date }}</h3>
        {%- if storyline %}
            <div id="storyline">
                {# `| replace(" ", "-")` takes the value in the variable, in this case `storyline`, and replaces all
                   spaces with hyphens. This is important when building links to other parts of the site. #}
                Storyline: <a href="{{ base_dir }}/archive/#{{ storyline | replace(" ", "-") }}">{{ storyline }}</a>
            </div>
        {%- endif %}
        {%- if characters %}
            <div id="characters">
            Characters:
            {# For loops let you take a list of a values and do something for each of those values. In this case,
               it runs through list of all the characters in this page, as defined by your info.ini file for this page,
               and it generates a link for each of those characters connecting to the `tagged` page for that
               character. #}
            {%- for character in characters %}
                {# The `if not loop.last` block at the end of the next line means that the ", " string will be added
                   after every character link EXCEPT the last one. #}
                <a href="{{ base_dir }}/tagged/{{ character }}/">{{ character }}</a>{% if not loop.last %}, {% endif %}
            {%- endfor %}
            </div>
        {%- endif %}
		
        {%- if tags %}
            <div id="tags">
            Tags:
            {%- for tag in tags %}
                <a class="tag-link" href="{{ base_dir }}/tagged/{{ tag }}/">{{ tag }}</a>{% if not loop.last %}, {% endif %}
            {%- endfor %}
            </div>
        {%- endif %}
	 
        <hr id="post-body-break">
        <div id="post-body">
{{ post_html }}
        </div>
        {% if transcripts %}
        <table id="transcripts-container" border>
            <tr>
                <td id="transcript-panel">
                    <h3>Transcript</h3>
                    <div id="active-transcript">
                    {% for language, transcript in transcripts.items() %}
                        <div class="transcript" id='{{ language }}-transcript'>
                        {{ transcript }}
                        </div>
                    {% endfor %}
                    </div>
                </td>
                <td id="language-list">
                    <label for="language-select">Languages</label>
                    <select id="language-select" size="7">
                        {% for language in transcripts.keys() %}
                        <option>{{ language }}</option>
                        {% endfor %}
                    </select>
                </td>
            </tr>
        </table>
        {% endif %}
    </div>
	
<h1> THIS IS HOME PAGE FOOTER</h1>
{%- endblock %}
