# API references

An overview of all available API references for Storybook.

## Configuration

  <thead>
    
      Name
      Description
    
  </thead>

  <tbody>
    
      <code>main.js|ts</code>

      
        Storybook's primary configuration file, which specifies your Storybook project's behavior,
        including the location of your stories, the addons you use, feature flags and other
        project-specific settings.
      
    

    
      <code>preview.js|jsx|ts|tsx</code>

      
        This configuration file controls the way stories are rendered. You can also use it to run
        code that applies to all stories.
      
    

    
      <code>manager.js|ts</code>

      
        This configuration file controls the behavior of Storybook's UI, the manager.
      
    

    
      CLI

      
        Storybook is a CLI tool. You can start Storybook in development mode or build a static
        version of your Storybook.
      
    

  </tbody>

## Stories

  <thead>
    
      Name
      Description
    
  </thead>

  <tbody>
    
      CSF

      
        Component Story Format (CSF) is the API for writing stories. It's an
        open standard based on ES6 modules that
        is portable beyond Storybook.
      
    

    
      ArgTypes

      
        ArgTypes specify the behavior of <a href="./writing-stories/args">args</a>. By specifying
        the type of an arg, you constrain the values that it can accept and provide information
        about args that are not explicitly set.
      
    

    
      Parameters

      
        Parameters are static metadata used to configure your <a href="./get-started/whats-a-story">stories</a> <a href="./addons">addons</a> in Storybook. They are specified at the story, meta (component), project (global) levels.
      
    

  </tbody>

## Docs

  <thead>
    
      Name
      Description
    
  </thead>

  <tbody>
    
      Doc blocks

      
        Storybook offers several doc blocks to help document your components and other aspects of
        your project.
      
    

  </tbody>
