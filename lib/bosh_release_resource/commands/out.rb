require 'digest'
require 'time'

module BoshReleaseResource
  module Commands
    class Out
      def initialize(bosh, writer=STDOUT)
        @bosh = bosh
        @writer = writer
      end

      def run(working_dir, request)
        validate! request

        releases = []

        find_releases(working_dir, request).each do |release_path|
          release = Release.new(release_path)
          bosh.upload_release(release_path)
          releases << release
        end

        response = {
          'version' => {
            'target' => bosh.target
          },
          'metadata' =>
            releases.map { |r| {'name' => 'release', 'value' => "#{r.name} v#{r.version}"} }
        }

        writer.puts response.to_json
      end

      private

      attr_reader :bosh, :writer

      def validate!(request)
        request.fetch('params').fetch('releases') { raise "params must include 'releases'" }
        raise 'releases must be an array of globs' unless enumerable?(request.fetch('params').fetch('releases'))
      end

      def find_releases(working_dir, request)
        globs = request.fetch('params').fetch('releases')

        glob(working_dir, globs)
      end

      def glob(working_dir, globs)
        paths = []

        globs.each do |glob|
          abs_glob = File.join(working_dir, glob)
          results = Dir.glob(abs_glob)

          raise "glob '#{glob}' matched no files" if results.empty?

          paths.concat(results)
        end

        paths.uniq
      end

      def enumerable?(object)
        object.is_a? Enumerable
      end
    end
  end
end
