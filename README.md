# Level Up Exercises

These are the combined exercises used at http://leveluprails.herokuapp.com. You can do them out of sequence, but you'll probably be missing the point. Do the right thing, visit the site.

## How to Do These Exercises

1. Fork this repo into your own space
  1. Click "Fork" at the top of this github page
  2. Fork this to your personal github
  3. Clone the forked repo (this will add your forked repo as 'origin')
2. Wait until you're asked to do one of the exercises
3. When your asked to complete an exercise:
  1. Use your fork, develop code, push it back upward
  2. Create a topic branch for the exercise
    * git checkout -b some_exercise
  3. Use the resources to appropriately code the exercise
  4. Commit all of these changes onto your topic branch
    * git add [files]
    * git commit -m "informative but entertaining message here"
  5. Push the topic branch to your forked repo (probably 'origin' but you can rename it if ya want)
    * git push origin some_exercise
  6. Create a pull request
    1. Go to your forked repo on Github and find the topic branch
    2. Click on "Compare and create pull request"
    3. Complete the pull request
      * (Keeping each exercise on its own topic branch will allow peers to easily review each independent exercise and offer feedback)
4. Profit!

## The First Lesson

Like everything else in the world, these exercises have errors and problems and typos. We experience this problem whenever we code, and the only way to stay sane as a group is to fix problems as we find them. Be a mensch, send pull requests.

Since the repo changes periodically, you may want to update your local repo with changes from 'upstream'.

Go into your local repo and add the main repo as a remote:

```
git remote add upstream git@github.com:jmmastey/level_up_exercises.git
```

If there are changes to the main upstream repo:

```
git checkout master
git fetch
git merge upstream/master --ff-only
```

If merge is aborted, you probably have changes on the master branch because you didn't create a topic branch to do your work.
Shame on you.
You can always just run 'git merge upstream/master' with out the fast forward option.
This will probably require you to
add and commit any of your changes, and this will also probably create a merge commit.
