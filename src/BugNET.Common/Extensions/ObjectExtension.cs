namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.ComponentModel;
    using System.Globalization;
    using System.Linq.Expressions;

    #endregion

    /// <summary>An object extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class ObjectExtension
    {
        #region Public Methods

        /// <summary>An object extension method that gets.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="input">The input to act on.</param>
        /// <param name="defaultValue">(Optional) The default value.</param>
        /// <param name="cultureInfo">(Optional) The format provider.</param>
        /// <returns>A T.</returns>
        public static T GetValue<T>(this object input, T defaultValue = default(T), CultureInfo cultureInfo = null)
        {
            T value = defaultValue;

            if (input == null)
            {
                return value;
            }

            cultureInfo = cultureInfo ?? CultureInfo.InvariantCulture;

            if (string.Equals(
                input.ToString().Replace(" ", string.Empty, StringComparison.CurrentCultureIgnoreCase).ToLower(cultureInfo),
                "true,false",
                StringComparison.OrdinalIgnoreCase))
            {
                string[] inputs = input.ToString().Split(',');
                bool value0 = bool.Parse(inputs[0]);
                bool value1 = bool.Parse(inputs[1]);

                value = (T)Convert.ChangeType(value0 || value1, typeof(T), cultureInfo);
            }
            else
            {
                try
                {
                    if (typeof(T).IsEnum)
                    {
                        if (int.TryParse(input.ToString(), NumberStyles.Any, cultureInfo, out _))
                        {
                            value = (T)Convert.ChangeType(input, typeof(int), cultureInfo);
                        }
                        else
                        {
                            value = (T)Enum.Parse(typeof(T), input.ToString());
                        }
                    }
                    else if (typeof(T) == typeof(bool))
                    {
                        string v = input.ToString().ToLower(cultureInfo);

                        switch (v)
                        {
                            case "true":
                            case "1":
                                value = (T)Convert.ChangeType("true", typeof(bool), cultureInfo);
                                break;
                            case "false":
                            case "0":
                                value = (T)Convert.ChangeType("false", typeof(bool), cultureInfo);
                                break;
                        }
                    }
                    else if (typeof(T).IsGenericType && (typeof(T).GetGenericTypeDefinition() == typeof(Nullable<>)))
                    {
                        var nc = new NullableConverter(typeof(T));
                        Type underlyingType = nc.UnderlyingType;

                        if (underlyingType.IsEnum)
                        {
                            if (int.TryParse(input.ToString(), out int _))
                            {
                                value = (T)Convert.ChangeType(input, typeof(int), cultureInfo);
                            }
                            else
                            {
                                value = (T)Enum.Parse(typeof(T), input.ToString());
                            }
                        }
                        else if (underlyingType == typeof(bool))
                        {
                            string v = input.ToString().ToLower(cultureInfo);

                            switch (v)
                            {
                                case "true":
                                case "1":
                                    value = (T)Convert.ChangeType("true", typeof(bool), cultureInfo);
                                    break;
                                case "false":
                                case "0":
                                    value = (T)Convert.ChangeType("false", typeof(bool), cultureInfo);
                                    break;
                            }
                        }
                        else
                        {
                            value = (T)Convert.ChangeType(input, underlyingType, cultureInfo);
                        }
                    }
                    else
                    {
                        value = (T)Convert.ChangeType(input, typeof(T), cultureInfo);
                    }
                }
                catch (Exception)
                {
                    return value;
                }
            }

            return value;
        }

        #endregion Public Methods
    }
}