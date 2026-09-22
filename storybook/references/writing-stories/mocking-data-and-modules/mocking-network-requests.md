# Mocking network requests

For components that make network requests (e.g. fetching data from a REST or GraphQL API), you can mock those requests using a tool like [Mock Service Worker (MSW)](https://mswjs.io/). MSW is an API mocking library, which relies on service workers to capture network requests and provides mocked data in response.

The [MSW addon](https://storybook.js.org/addons/msw-storybook-addon/) brings this functionality into Storybook, allowing you to mock API requests in your stories. Below is an overview of how to set up and use the addon.

The instructions and snippets here are for **v3 of the MSW addon**. If you're using v2, please refer to an [older version of this page](https://storybook.js.org/docs/9/writing-stories/mocking-data-and-modules/mocking-network-requests.md) for guidance.

After updating `msw-storybook-addon` to v3, you can migrate your configuration and stories from v2 to v3 automatically using the codemod:

```shell
npx msw-storybook-migrate
```

For more information, see the [MSW migration guide](https://github.com/mswjs/msw-storybook-addon/blob/main/MIGRATION.md#from-2xx-to-3xx).

## Set up the MSW addon

First, if necessary, run this command to install MSW and the MSW addon:

```sh
npm install msw msw-storybook-addon --save-dev
```

```sh
pnpm add msw msw-storybook-addon --save-dev
```

```sh
yarn add msw msw-storybook-addon --save-dev
```

If you're not already using MSW, generate the service worker file necessary for MSW to work:

```shell
npx msw init ./public --save
```

```shell
yarn dlx msw init ./public --save
```

```shell
pnpm dlx msw init ./public --save
```

Then ensure the [`staticDirs`](https://storybook.js.org/docs/api/main-config/main-config-static-dirs.md) property in your Storybook configuration will include the generated service worker file (in `/public`, by default):

```ts
// .storybook/main.ts — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const config: StorybookConfig = {
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
};

export default config;
```

```ts
// .storybook/main.ts — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default defineMain({
  framework: '@storybook/your-framework',
  stories: ['../src/**/*.mdx', '../src/**/*.stories.@(js|jsx|mjs|ts|tsx)'],
  staticDirs: ['../public', '../static'],
});
```

Finally, initialize the addon and register it for all stories with a [project-level loader](https://storybook.js.org/docs/writing-stories/loaders.md#global-loaders) (if using CSF 3) or by adding the addon to `preview.ts` (if using CSF Next):

```ts
// .storybook/preview.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const preview: Preview = {
  /*
   * Register the MSW loader for all stories
   * See https://github.com/mswjs/msw-storybook-addon#csf-30
   * to learn how to customize it
   */
  loaders: [mswLoader()],
};

export default preview;
```

```ts
// .storybook/preview.tsx — CSF Next 🧪
// Replace your-framework with the framework you are using (e.g., react-vite, nextjs, nextjs-vite)

export default definePreview({
  /*
   * Register the MSW loader for all stories
   * See https://github.com/mswjs/msw-storybook-addon#csf-next
   * to learn how to customize it
   */
  addons: [addonMsw()],
});
```

## Mocking REST requests

If your component fetches data from a REST API, you can use MSW to mock those requests in Storybook. As an example, consider this document screen component:

```ts
// YourPage.tsx

// Example hook to retrieve data from an external endpoint
function useFetchData() {
  const [status, setStatus] = useState<string>('idle');
  const [data, setData] = useState<any[]>([]);
  useEffect(() => {
    setStatus('loading');
    fetch('https://your-restful-endpoint')
      .then((res) => {
        if (!res.ok) {
          throw new Error(res.statusText);
        }
        return res;
      })
      .then((res) => res.json())
      .then((data) => {
        setStatus('success');
        setData(data);
      })
      .catch(() => {
        setStatus('error');
      });
  }, []);

  return {
    status,
    data,
  };
}

export function DocumentScreen() {
  const { status, data } = useFetchData();

  const { user, document, subdocuments } = data;

  if (status === 'loading') {
    return <p>Loading...</p>;
  }
  if (status === 'error') {
    return <p>There was an error fetching the data!</p>;
  }
  return (
    
      
      
    
  );
}
```

This example uses the [`fetch` API](https://developer.mozilla.org/en-US/docs/Web/API/fetch) to make network requests. If you're using a different library (e.g. [`axios`](https://axios-http.com/)), you can apply the same principles to mock network requests in Storybook.

With the MSW addon, we can write stories that use MSW to mock the REST requests. Here's an example of two stories for the document screen component: one that fetches data successfully and another that fails.

```ts
// YourPage.stories.ts|tsx — CSF 3
// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, vue3-vite, etc.

const meta = {
  component: DocumentScreen,
} satisfies Meta<typeof DocumentScreen>;

export default meta;
type Story = StoryObj<typeof meta>;

// 👇 The mocked data that will be used in the story
const TestData = {
  user: {
    userID: 1,
    name: 'Someone',
  },
  document: {
    id: 1,
    userID: 1,
    title: 'Something',
    brief: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    status: 'approved',
  },
  subdocuments: [
    {
      id: 1,
      userID: 1,
      title: 'Something',
      content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      status: 'approved',
    },
  ],
};

export const MockedSuccess: Story = {
  beforeEach({ msw }) {
    msw.use(
      http.get('https://your-restful-endpoint/', () => {
        return HttpResponse.json(TestData);
      }),
    );
  },
};

export const MockedError: Story = {
  beforeEach({ msw }) {
    msw.use(
      http.get('https://your-restful-endpoint', async () => {
        await delay(800);
        return new HttpResponse(null, {
          status: 403,
        });
      }),
    );
  },
};
```

```ts
// YourPage.stories.ts|tsx — CSF Next 🧪

const meta = preview.meta({
  component: DocumentScreen,
});

// 👇 The mocked data that will be used in the story
const TestData = {
  user: {
    userID: 1,
    name: 'Someone',
  },
  document: {
    id: 1,
    userID: 1,
    title: 'Something',
    brief: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    status: 'approved',
  },
  subdocuments: [
    {
      id: 1,
      userID: 1,
      title: 'Something',
      content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      status: 'approved',
    },
  ],
};

export const MockedSuccess = meta.story({
  beforeEach({ msw }) {
    msw.use(
      http.get('https://your-restful-endpoint/', () => {
        return HttpResponse.json(TestData);
      }),
    );
  },
});

export const MockedError = meta.story({
  beforeEach({ msw }) {
    msw.use(
      http.get('https://your-restful-endpoint', async () => {
        await delay(800);
        return new HttpResponse(null, {
          status: 403,
        });
      }),
    );
  },
});
```

## Mocking GraphQL requests

GraphQL is another common way to fetch data in components. You can use MSW to mock GraphQL requests in Storybook. Here's an example of a document screen component that fetches data from a GraphQL API:

```ts
// YourPage.tsx

const AllInfoQuery = gql`
  query AllInfo {
    user {
      userID
      name
    }
    document {
      id
      userID
      title
      brief
      status
    }
    subdocuments {
      id
      userID
      title
      content
      status
    }
  }
`;

interface Data {
  allInfo: {
    user: {
      userID: number;
      name: string;
      opening_crawl: boolean;
    };
    document: {
      id: number;
      userID: number;
      title: string;
      brief: string;
      status: string;
    };
    subdocuments: {
      id: number;
      userID: number;
      title: string;
      content: string;
      status: string;
    };
  };
}

function useFetchInfo() {
  const { loading, error, data } = useQuery<Data>(AllInfoQuery);

  return { loading, error, data };
}

export function DocumentScreen() {
  const { loading, error, data } = useFetchInfo();

  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>There was an error fetching the data!</p>;
  }

  return (
    
      
      
    
  );
}
```

This example uses GraphQL with [Apollo Client](https://www.apollographql.com/docs/) to make network requests. If you're using a different library (e.g. [URQL](https://formidable.com/open-source/urql/) or [React Query](https://react-query.tanstack.com/)), you can apply the same principles to mock network requests in Storybook.

The MSW addon allows you to write stories that use MSW to mock the GraphQL requests. Here's an example demonstrating two stories for the document screen component. The first story fetches data successfully, while the second story fails.

```tsx
// YourPage.stories.ts|tsx — CSF 3

// Replace your-framework with the framework you are using, e.g. react-vite, nextjs, nextjs-vite, etc.

const mockedClient = new ApolloClient({
  uri: 'https://your-graphql-endpoint',
  cache: new InMemoryCache(),
  defaultOptions: {
    watchQuery: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
    query: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
  },
});

//👇The mocked data that will be used in the story
const TestData = {
  user: {
    userID: 1,
    name: 'Someone',
  },
  document: {
    id: 1,
    userID: 1,
    title: 'Something',
    brief: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    status: 'approved',
  },
  subdocuments: [
    {
      id: 1,
      userID: 1,
      title: 'Something',
      content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      status: 'approved',
    },
  ],
};
const meta = {
  component: DocumentScreen,
  decorators: [
    (Story) => (
      
        
      
    ),
  ],
} satisfies Meta<typeof DocumentScreen>;

export default meta;
type Story = StoryObj<typeof meta>;

export const MockedSuccess: Story = {
  beforeEach({ msw }) {
    msw.use(
      graphql.query('AllInfoQuery', () => {
        return HttpResponse.json({
          data: {
            allInfo: {
              ...TestData,
            },
          },
        });
      }),
    );
  },
};

export const MockedError: Story = {
  beforeEach({ msw }) {
    msw.use(
      graphql.query('AllInfoQuery', async () => {
        await delay(800);
        return HttpResponse.json({
          errors: [
            {
              message: 'Access denied',
            },
          ],
        });
      }),
    );
  },
};
```

```tsx
// YourPage.stories.ts|tsx — CSF Next 🧪

const mockedClient = new ApolloClient({
  uri: 'https://your-graphql-endpoint',
  cache: new InMemoryCache(),
  defaultOptions: {
    watchQuery: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
    query: {
      fetchPolicy: 'no-cache',
      errorPolicy: 'all',
    },
  },
});

//👇The mocked data that will be used in the story
const TestData = {
  user: {
    userID: 1,
    name: 'Someone',
  },
  document: {
    id: 1,
    userID: 1,
    title: 'Something',
    brief: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    status: 'approved',
  },
  subdocuments: [
    {
      id: 1,
      userID: 1,
      title: 'Something',
      content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      status: 'approved',
    },
  ],
};
const meta = preview.meta({
  component: DocumentScreen,
  decorators: [
    (Story) => (
      
        
      
    ),
  ],
});

export const MockedSuccess = meta.story({
  beforeEach({ msw }) {
    msw.use(
      graphql.query('AllInfoQuery', () => {
        return HttpResponse.json({
          data: {
            allInfo: {
              ...TestData,
            },
          },
        });
      }),
    );
  },
});

export const MockedError = meta.story({
  beforeEach({ msw }) {
    msw.use(
      graphql.query('AllInfoQuery', async () => {
        await delay(800);
        return HttpResponse.json({
          errors: [
            {
              message: 'Access denied',
            },
          ],
        });
      }),
    );
  },
});
```

## Configuring MSW for stories

In the examples above, note how each story is configured using `beforeEach` on the stories to define the request handlers for the mock server. You can also use `beforeEach` at the component (meta) level to apply handlers to all stories in that file or at the project level (in `preview.ts`) to apply them to all stories in the project.

If using CSF 3, you can also use the `msw` parameter to define handlers for a story, component, or project. See the [older version of this page](https://storybook.js.org/docs/9/writing-stories/mocking-data-and-modules/mocking-network-requests.md) for examples of using the `msw` parameter.
