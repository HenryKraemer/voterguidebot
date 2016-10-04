module Publisher
  class National < AVG

    def resource
      "https://#{bucket}"
    end

    private

    def generate
      FileUtils.mkdir_p asset_path
      render_index
      render_contests
      sync_assets
    end

    def render_index
      render_static 'index.html'
    end
  end
end
