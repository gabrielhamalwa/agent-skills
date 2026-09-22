# Building pages with Storybook

Storybook helps you build any component, from small “atomic” components to composed pages. But as you move up the component hierarchy toward the page level, you deal with more complexity.

There are many ways to build pages in Storybook. Here are common patterns and solutions.

- Pure presentational pages.
- Connected components (e.g., network requests, context, browser environment).

## Pure presentational pages

Teams at the BBC, The Guardian, and the Storybook maintainers themselves build pure presentational pages. If you take this approach, you don't need to do anything special to render your pages in Storybook.

It's straightforward to write components to be fully presentational up to the screen level. That makes it easy to show in Storybook. The idea is that you do all the messy “connected” logic in a single wrapper component in your app outside of Storybook. You can see an example of this approach in the [Data](https://storybook.js.org/tutorials/intro-to-storybook/react/en/data/) chapter of the Intro to Storybook tutorial.

The benefits:

- Easy to write stories once components are in this form.
- All the data for the story is encoded in the args of the story, which works well with other parts of Storybook's tooling (e.g. [controls](https://storybook.js.org/docs/essentials/controls.md)).

The downsides:

- Your existing app may not be structured in this way, and it may be difficult to change it.

- Fetching data in one place means that you need to drill it down to the components that use it. This can be natural in a page that composes one big GraphQL query (for instance), but other data fetching approaches may make this less appropriate.

- It's less flexible if you want to load data incrementally in different places on the screen.

### Args composition for presentational screens

When you are building screens in this way, it is typical that the inputs of a composite component are a combination of the inputs of the various sub-components it renders. For instance, if your screen renders a page layout (containing details of the current user), a header (describing the document you are looking at), and a list (of the subdocuments), the inputs of the screen may consist of the user, document and subdocuments.

```tsx
// YourPage.ts|tsx

export interface DocumentScreenProps {
  user?: {};
  document?: Document;
  subdocuments?: SubDocuments[];
}

export function DocumentScreen({ user, document, subdocuments }: DocumentScreenProps) {
  return (
    
      
      
    
  );
}
```

In such cases, it is natural to use [args composition](https://storybook.js.org/docs/writing-stories/args.md#args-composition) to build the stories for the page based on the stories of the sub-components:

```ts
// YourPage.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

// 👇 Imports the required stories

const meta = {
  component: DocumentScreen,
} satisfies Meta<typeof DocumentScreen>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Simple: Story = {
  args: {
    user: PageLayout.Simple.args.user,
    document: DocumentHeader.Simple.args.document,
    subdocuments: DocumentList.Simple.args.documents,
  },
};
```

```ts
// YourPage.stories.ts|tsx — CSF Next 🧪

// 👇 Imports the required stories

const meta = preview.meta({
  component: DocumentScreen,
});

export const Simple = meta.story({
  args: {
    user: PageLayout.Simple.input.args.user,
    document: DocumentHeader.Simple.input.args.document,
    subdocuments: DocumentList.Simple.input.args.documents,
  },
});
```

This approach is beneficial when the various subcomponents export a complex list of different stories. You can pick and choose to build realistic scenarios for your screen-level stories without repeating yourself. Your story maintenance burden is minimal by reusing the data and taking a Don't-Repeat-Yourself(DRY) philosophy.

## Mocking connected components

Connected components are components that depend on external data or services. For example, a full page component is often a connected component. When you render a connected component in Storybook, you need to mock the data or modules that the component depends on. There are various layers in which you can do that.

### [Mocking imports](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-modules.md)

Components can depend on modules that are imported into the component file. These can be from external packages or internal to your project. When rendering those components in Storybook or testing them, you may want to mock those modules to control their behavior.

### [Mocking API Services](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-network-requests.md)

For components that make network requests (e.g., fetching data from a REST or GraphQL API), you can mock those requests in your stories.

### [Mocking providers](https://storybook.js.org/docs/writing-stories/mocking-data-and-modules/mocking-providers.md)

Components can receive data or configuration from context providers. For example, a styled component might access its theme from a ThemeProvider or Redux uses React context to provide components access to app data. You can mock a provider and the value it's providing and wrap your component with it in your stories.

### Avoiding mocking dependencies

It's possible to avoid mocking the dependencies of connected "container" components entirely by passing them around via props or React context. However, it requires a strict split of the container and presentational component logic. For example, if you have a component responsible for data fetching logic and rendering DOM, it will need to be mocked as previously described.

It’s common to import and embed container components amongst presentational components. However, as we discovered earlier, we’ll likely have to mock their dependencies or the imports to render them within Storybook.

Not only can this quickly grow to become a tedious task, but it’s also challenging to mock container components that use local states. So, instead of importing containers directly, a solution to this problem is to create a React context that provides the container components. It allows you to freely embed container components as usual, at any level in the component hierarchy without worrying about subsequently mocking their dependencies; since we can swap out the containers themselves with their mocked presentational counterpart.

We recommend dividing context containers up over specific pages or views in your app. For example, if you had a `ProfilePage` component, you might set up a file structure as follows:

```
ProfilePage.js
ProfilePage.stories.js
ProfilePageContainer.js
ProfilePageContext.js
```

It’s also often helpful to set up a “global” container context (perhaps named `GlobalContainerContext`) for container components that may be rendered on every page of your app and add them to the top level of your application. While it’s possible to place every container within this global context, it should only provide globally required containers.

Let’s look at an example implementation of this approach.

First, create a React context, and name it `ProfilePageContext`. It does nothing more than export a React context:

```js
// ProfilePageContext.js|jsx

const ProfilePageContext = createContext();

export default ProfilePageContext;
```

`ProfilePage` is our presentational component. It will use the `useContext` hook to retrieve the container components from `ProfilePageContext`:

```js
// ProfilePage.js|jsx

export const ProfilePage = ({ name, userId }) => {
  const { UserPostsContainer, UserFriendsContainer } = useContext(ProfilePageContext);

  return (
    <div>
      <h1>{name}</h1>
      
      
    </div>
  );
};
```

#### Mocking containers in Storybook

In the context of Storybook, instead of providing container components through context, we’ll instead provide their mocked counterparts. In most cases, the mocked versions of these components can often be borrowed directly from their associated stories.

```js
// ProfilePage.stories.js|jsx

//👇 Imports a specific story from a story file

export default {
  component: ProfilePage,
};

const ProfilePageProps = {
  name: 'Jimi Hendrix',
  userId: '1',
};

const context = {
  //👇 We can access the `userId` prop here if required:
  UserPostsContainer({ userId }) {
    return ;
  },
  // Most of the time we can simply pass in a story.
  // In this case we're passing in the `normal` story export
  // from the `UserFriends` component stories.
  UserFriendsContainer: UserFriendsNormal,
};

export const Normal = {
  render: () => (
    <ProfilePageContext.Provider value={context}>
      
    </ProfilePageContext.Provider>
  ),
};
```

If the same context applies to all `ProfilePage` stories, we can use a [decorator](https://storybook.js.org/docs/writing-stories/decorators.md).

#### Providing containers to your application

Now, in the context of your application, you’ll need to provide `ProfilePage` with all of the container components it requires by wrapping it with `ProfilePageContext.Provider`:

For example, in Next.js, this would be your `pages/profile.js` component.

```js
// pages/profile.js|jsx

//👇 Ensure that your context value remains referentially equal between each render.
const context = {
  UserPostsContainer,
  UserFriendsContainer,
};

export const AppProfilePage = () => {
  return (
    <ProfilePageContext.Provider value={context}>
      
    </ProfilePageContext.Provider>
  );
};
```

#### Mocking global containers in Storybook

If you’ve set up `GlobalContainerContext`, you’ll need to set up a decorator within Storybook’s `preview.js` to provide context to all stories. For example:

```tsx
// .storybook/preview.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const context = {
  NavigationContainer: NavigationNormal,
};

const AppDecorator = (storyFn) => {
  return (
    <GlobalContainerContext.Provider value={context}>{storyFn()}</GlobalContainerContext.Provider>
  );
};

const preview: Preview = {
  decorators: [AppDecorator],
};

export default preview;
```

```tsx
// .storybook/preview.tsx — CSF Next 🧪

// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

const context = {
  NavigationContainer: NavigationNormal,
};

const AppDecorator = (storyFn) => {
  return (
    <GlobalContainerContext.Provider value={context}>{storyFn()}</GlobalContainerContext.Provider>
  );
};

export default definePreview({
  decorators: [AppDecorator],
});
```
