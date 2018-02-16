namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Linq.Expressions;

    #endregion

    /// <summary>An enumerable extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class EnumerableExtension
    {
        #region Public Methods

        /// <summary>Enumerates sort in this collection.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <exception cref="ArgumentNullException">Thrown when one or more required arguments are null.</exception>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="source">The source to act on.</param>
        /// <param name="sortExpression">The sort expression.</param>
        /// <returns>An enumerator that allows foreach to be used to process sort in this collection.</returns>
        public static IEnumerable<T> Sort<T>(this IEnumerable<T> source, string sortExpression)
        {
            if (source == null)
            {
                throw new ArgumentNullException(nameof(source));
            }

            string[] sortParts = sortExpression.Split(' ');
            ParameterExpression param = Expression.Parameter(typeof(T), string.Empty);

            IEnumerable<T> enumerable = source.ToList();

            try
            {
                MemberExpression property = Expression.Property(param, sortParts[0]);
                Expression<Func<T, object>> sortLambda = Expression.Lambda<Func<T, object>>(Expression.Convert(property, typeof(object)), param);

                if ((sortParts.Length > 1) && sortParts[1].Equals("desc", StringComparison.OrdinalIgnoreCase))
                {
                    return enumerable.AsQueryable().OrderByDescending(sortLambda);
                }

                return enumerable.AsQueryable().OrderBy(sortLambda);
            }
            catch (ArgumentException)
            {
                return enumerable;
            }
        }

        #endregion Public Methods
    }
}