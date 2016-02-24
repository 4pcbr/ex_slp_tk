defmodule ExSlp.Client do

  alias ExSlp.Tool
  import ExSlp.Util, only: [ format_servise_url: 1, format_args: 1, format_opts: 1 ]

  def findsrvs( service ), do: findsrvs( service, [], [] )

  def findsrvs( service, opts ), do: findsrvs( service, [], opts )

  def findsrvs( service, args, opts ) do
    args = format_args args
    opts = format_opts opts
    Tool.exec_cmd( args, :findsrvs, [ format_servise_url( service ), opts ])
  end


  def findattrs( url, args, opts ) do
    args = format_args args
    opts = format_opts opts
    Tool.exec_cmd( args, :findattrs, [ format_servise_url( url ), opts ])
  end

  def findsrvtypes, do: findsrvtypes( nil, [] )

  def findsrvtypes( authority ), do: findsrvtypes( authority, [] )

  def findsrvtypes( authority, args ) do
    args = format_args args
    opts = case authority do
      nil -> []
      _   -> [ authority ]
    end
    Tool.exec_cmd( args, :findsrvtypes, opts )
  end

  def findscopes( args ) do
    args = format_args args
    Tool.exec_cmd( args, :findscopes )
  end

  def getproperty( property ), do: getproperty( property, [] )

  def getproperty( property, args ) do
    args = format_args args
    case res = Tool.exec_cmd( args, :getproperty, [ property ] ) do
      { :ok, response } ->
        { :ok, String.replace( response, "#{property} = ", "" ) }
      _ -> res
    end
  end

end
