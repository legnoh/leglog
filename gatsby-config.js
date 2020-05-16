module.exports = {
  siteMetadata: {
    title: `leglog`,
    name: `leglog`,
    siteUrl: `https://leglog.lkj.io`,
    description: `legnoh's life log :)`,
    hero: {
      heading: `leglog へようこそ。<br>日常、DIY、Web技術などの私見を綴っています。`,
      maxWidth: 652,
    },
    social: [
      {
        name: `medium`,
        url: `https://legwiki.lkj.io`,
      },
      {
        name: `twitter`,
        url: `https://twitter.com/legnoh`,
      },
      {
        name: `facebook`,
        url: `https://facebook.com/legnoh`,
      },
      {
        name: `instagram`,
        url: `https://instagram.com/legnoh`,
      },
      {
        name: `github`,
        url: `https://github.com/legnoh`,
      },
      {
        name: `paypal`,
        url: `https://paypal.me/legnoh?locale.x=ja_JP`,
      },
    ],
  },
  plugins: [
    `@pauliescanlon/gatsby-mdx-embed`,
    {
      resolve: "@narative/gatsby-theme-novela",
      options: {
        contentPosts: "content/posts",
        contentAuthors: "content/authors",
        authorsPage: true,
        sources: {
          local: true
        },
      },
    },
    {
      resolve: `gatsby-plugin-manifest`,
      options: {
        name: `leglog`,
        short_name: `leglog`,
        start_url: `/`,
        background_color: `#fff`,
        theme_color: `#fff`,
        display: `standalone`,
        icon: `src/assets/favicon.svg`,
      },
    },
  ],
};
