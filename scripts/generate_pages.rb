#!/usr/bin/env ruby
# Generate collection pages from data files
# Usage: ruby scripts/generate_pages.rb

require 'yaml'
require 'fileutils'

ROOT = File.expand_path('..', __dir__)

def load_data(filename)
  path = File.join(ROOT, '_data', filename)
  YAML.load_file(path)
end

def write_page(dir, slug, frontmatter)
  FileUtils.mkdir_p(dir)
  path = File.join(dir, "#{slug}.md")
  File.open(path, 'w') do |f|
    f.puts "---"
    frontmatter.each do |key, value|
      if value.is_a?(Array)
        f.puts "#{key}:"
        value.each { |item| f.puts "  - \"#{item}\"" }
      elsif value.to_s.include?('"') || value.to_s.include?(':') || value.to_s.include?('#')
        # Use single quotes for values containing double quotes, colons, or hashes
        f.puts "#{key}: '#{value.to_s.gsub("'", "''")}'"
      else
        f.puts "#{key}: \"#{value}\""
      end
    end
    f.puts "---"
  end
  path
end

# --- Generate Track Pages ---
tracks_dir = File.join(ROOT, '_tracks')
tracks = load_data('tracks.yml')

puts "Generating #{tracks.length} track pages..."
tracks.each do |track|
  slug = track['slug']
  name = track['name']
  location = track['location']
  country = track['country']
  type = track['type']
  surface = track['surface']
  length = track['length']

  # Build unique title (under 60 chars ideally for SERP)
  title = "Kart Weight Setup for #{name} | Balance Calculator & Tips"

  # Build unique description (150-160 chars)
  description = "Optimize your kart weight distribution for #{name} in #{location}. Setup tips for this #{type} #{surface} track."
  if description.length < 140
    description += " Use KartBalance for precise corner weights."
  end
  # Trim to 160 chars max
  description = description[0..159]

  frontmatter = {
    'layout' => 'track',
    'title' => title,
    'description' => description,
    'name' => name,
    'location' => location,
    'country' => country,
    'type' => type,
    'surface' => surface,
    'length' => length,
    'track_description' => track['description']
  }

  path = write_page(tracks_dir, slug, frontmatter)
  puts "  Created: #{path}"
end

# --- Generate Brand Pages ---
brands_dir = File.join(ROOT, '_brands')
brands = load_data('kart_brands.yml')

puts "\nGenerating #{brands.length} brand pages..."
brands.each do |brand|
  slug = brand['slug']
  name = brand['name']
  country = brand['country']
  manufacturer = brand['manufacturer']

  # Build unique title
  if name.downcase.include?('kart')
    title = "#{name} Weight Distribution Guide | Setup Tips"
  else
    title = "#{name} Kart Weight Distribution Guide | Setup Tips"
  end

  # Build unique description (150-160 chars)
  description = "Complete weight distribution guide for #{name} karts. Learn chassis balance tips, setup notes, and corner weight optimization for #{name} racing karts."
  description = description[0..159]

  frontmatter = {
    'layout' => 'brand',
    'title' => title,
    'description' => description,
    'name' => name,
    'country' => country,
    'manufacturer' => manufacturer,
    'popular_models' => brand['popular_models'],
    'chassis_type' => brand['chassis_type'],
    'typical_weight' => brand['typical_weight'],
    'known_for' => brand['known_for'],
    'setup_notes' => brand['setup_notes']
  }

  path = write_page(brands_dir, slug, frontmatter)
  puts "  Created: #{path}"
end

# --- Generate Class Pages ---
classes_dir = File.join(ROOT, '_classes')
classes = load_data('classes.yml')

puts "\nGenerating #{classes.length} class pages..."
classes.each do |klass|
  slug = klass['slug']
  name = klass['name']
  full_name = klass['full_name']

  # Build unique title (under 60 chars ideally for SERP)
  title = "#{name} Kart Weight Distribution Setup Guide | KartBalance"

  # Build unique description (150-160 chars)
  description = "#{full_name} kart weight distribution guide. Setup tips for #{name} racing, corner weight optimization, and ballast strategy at #{klass['min_weight']} minimum."
  description = description[0..159]

  frontmatter = {
    'layout' => 'class',
    'title' => title,
    'description' => description,
    'name' => name,
    'slug' => slug,
    'full_name' => full_name,
    'engine_type' => klass['engine_type'],
    'min_weight' => klass['min_weight'],
    'typical_age' => klass['typical_age'],
    'class_description' => klass['description'],
    'weight_notes' => klass['weight_notes']
  }

  path = write_page(classes_dir, slug, frontmatter)
  puts "  Created: #{path}"
end

puts "\nDone! Generated #{tracks.length} track pages, #{brands.length} brand pages, and #{classes.length} class pages."
